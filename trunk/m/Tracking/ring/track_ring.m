## -*- texinfo -*-
## @deftypefn {Function File} {@var{particles} =} track_ring(@var{track_rec}, @var{particle_rec}, @var{n_loop})
## @deftypefnx {Function File} {[@var{particles}, @var{last_particles}, @var{ini_particles}] =} track_ring(@var{track_rec}, @var{particle_rec}, @var{n_loop})
##
## @var{track_rec} is a structure which must have following fields.
## @table @code
## @item lattice
## @item brho
## @end table
## 
## @var{track_rec} can have following optional fields.
##
## @table @code
## @item sextupoles
## @item kickers
## @item bm_sx
## S*L [1/m] Sextupole strength of BM fringing field
## @item start_elem
## @item hit_elements
## @end table
##
## The 'hit_elements' field should have a cell array of structures which have two fields of 'name' and 'positions'. The 'name' field specify element names with a regular expression. The following is an example of 'hit_elements' field.
##
## @verbatim
##  track_rec_9201_fsx.hit_elements =...
##    {setfields(struct, "name", "MRD9IN", "position", {"entrance"}),...
##     setfields(struct, "name", "MRD9OUT", "position", {"exit"}),...
##     setfields(struct, "name", "BMD\\dIN", "position", {"entrance"}),...
##     setfields(struct, "name", "BMD\\dOUT", "position", {"exit"}),...
##     setfields(struct, "name", "^ESD$", "position", {"entrance"}),...
##     setfields(struct, "name", "QF\\d", "position", {"center"}),...
##     setfields(struct, "name", "QD\\d", "position", {"center"})};
## @end verbatim
##
## See generate_particles for the fields @var{particle_rec} can have.
##
## @end deftypefn

##== History
## 2008-05-16
## * hit_elements の名前指定 field を regname から name に変更
## 
## 2008-05-14
## * hit_element を指定できるようにした。
## * Q や BM を hit_element に自動的に含めない。
## 
## 2008-03-17
## RFK を設定できるようにした。
##
## 2008-03-06
## * start_elem を設定できるようにした。
##
## 2007.10.03
## * separatrixTracking.m から派生。より一般化する。
## * thin lenz 近似だけをサポートする。

##  kicker の真ん中に hit_checker を設定できない
##  kicker と hit_checker が競合する。
##  任意の element の真ん中に特殊要素を任意の数だけ挿入できる仕様にすべきだった
##  それで、すべてを統一的に扱える。

function varargout = track_ring(track_rec, particle_rec, n_loop, varargin)
  if (isfield(track_rec, "check_hit"))
    check_hit = track_rec.check_hit;
  else
    check_hit = false;
  end
  
  logdir = [];
  loopstep = 1;
  save_history = @__dummy;
  if (length(varargin) > 0)
    logdir = varargin{1};
    if (!mkdir(logdir));
      if (!isdir(logdir))
        error(sprintf("%s is not directory", logdir));
      endif
      system(sprintf("rm -rf %s/*.mat", logdir));
    endif
    if (length(varargin) > 1)
      loopstep = varargin{2};
    else
      loopstep = 500;
    endif
    if (loopstep > n_loop)
      loopstep = 1;
    endif
    save_history = @__save_history;
    save_history("loopmax", n_loop, "location", logdir);
  endif
  
  ##== setup sextupole magnet
  if (isfield(track_rec, "sextupoles"))
    track_rec = setup_sextupoles(track_rec);
  else
    warning("No sextupole elements.");
  endif
  all_elements = track_rec.lattice;

  ##== shift all_elements to change start point
  if (isfield(track_rec, "start_elem"))
    [an_elem, ind_elem] = element_with_name(all_elements, track_rec.start_elem);
#    ind_elem
#    size(all_elements)
    all_elements = {all_elements{ind_elem:length(all_elements)}, all_elements{1:ind_elem-1}}';
    #size(all_elements)
  endif

  ##== setup globals
  global _particle_history;
  initialize_global_storages();

  global __particle_id__;
  __particle_id__ = [];

  ##== setup initial particles
  if (isstruct(particle_rec))
    if (isfield(particle_rec, "particles"))
      ini_particles = particle_rec.particles;
      particle_rec.num = columns(ini_particles);
      if (isfield(particle_rec, "id"))
        __particle_id__ = particle_rec.id;
      end
    else
      #ini_particles = generate_particles(particle_rec, track_rec.lattice{end});
      if (isfield(particle_rec, "kind") && (strcmp(particle_rec.kind, "third")))
        particle_rec = generate_particles3(particle_rec, track_rec);
        ini_particles = particle_rec.particles;
      else
        ini_particles = generate_particles(particle_rec, all_elements{end});
      end
      __particle_id__ = 1:columns(ini_particles);
    end
  else
    ini_particles = particle_rec;
    __particle_id__ = 1:columns(ini_particles);
  endif
  
  n_particles = columns(ini_particles);
  if (isempty( __particle_id__))
    __particle_id__ = 1:n_particles;
  endif
  
  
  ##== setup hit checkers;
  if (check_hit)
    _particle_history.hit = struct;
    for n = 1:length(all_elements)
      an_elem = all_elements{n};
      for m = 1:length(track_rec.hit_elements)
        hit_elem = track_rec.hit_elements{m};
        if (regexp(an_elem.name, hit_elem.name))
          hms = {an_elem};
          if (contain_str(hit_elem.position, "center"))
            hms = { half_element(an_elem, true)...
              , hit_checker_with_element(an_elem)...
              , half_element(an_elem, false)};
          endif
          
          if (contain_str(hit_elem.position, "entrance"))
            hms = {hit_checker_with_element(an_elem, "entrance"), hms};
          endif
          
          if (contain_str(hit_elem.position, "exit"))
            hms(end+1) = hit_checker_with_element(an_elem, "exit");
          endif
          
          all_elements{n} = hms;
        endif
      endfor      
    endfor
    all_elements = flat_cell(all_elements);
  endif

  
  ##== setup kickers
  if (isfield(track_rec, "kickers"))
    for n = 1:length(track_rec.kickers)
      kicker_rec = track_rec.kickers{n};
      #kicker_rec.kickMat = repmat(kicker_rec.kickVector, 1, n_particles);
      [an_elem, ind_elem] = element_with_name(all_elements, kicker_rec.name);
      all_elements{ind_elem} = kicker_rec;
    endfor
  endif
  
  ##== setup BM fringing sextupole
  if (isfield(track_rec, "bm_sx"))
    for n = 1:length(all_elements)
      if (is_BM(all_elements{n}))
        all_elements{n} = setup_fringing_sx(all_elements{n}, track_rec.bm_sx);
      endif
    endfor
    all_elements = flat_cell(all_elements);
  endif
  
  ##== setup RFK
  if (isfield(track_rec, "rfks"))
    for n = 1:length(track_rec.rfks)
      rfk_rec = track_rec.rfks{n};
      [an_elem, ind_elem] = element_with_name(all_elements, rfk_rec.name);
      all_elements{ind_elem} = setup_rfk(rfk_rec, an_elem...
                                        , track_rec.brho, particle_rec);
    end
  end
  
  ##== setup monitors
  if (isfield(track_rec, "monitors"))
    monitor_names = track_rec.monitors;
  else
    #monitor_names = {"ESD"};
    monitor_names ={};
    warning("No monitors are givend.");
  endif
  
  for n = 1:length(monitor_names)
    [an_elem, ind_elem] = element_with_name(all_elements, monitor_names{n});
    all_elements{ind_elem} = monitor_with_element(an_elem);
    if (loopstep == 1)
      m = n_loop;
    else
      m = loopstep;
    endif
    _particle_history.monitors.(monitor_names{n}) = cell(1, m);
  endfor
  
  #element_with_name(all_elements, "SX1")
  
  ##== build span array
  span_array = {};
  a_span = {};
  for n = 1:length(all_elements)
    an_elem = all_elements{n};
    if (isfield(an_elem, "track_info") && strcmp(an_elem.track_info, "special"))
      if (length(a_span) > 0)
        span_array{end+1} = span_with_elements(a_span);
        a_span = {};
      endif
      span_array{end+1} = an_elem;
      an_elem = [];
    else
      a_span{end+1} = an_elem;
    endif
  endfor
  
  if (length(a_span))
    span_array{end+1} = span_with_elements(a_span);
    a_span = {};
  endif
  
  ##== start tracking
  particles = ini_particles;
  global __revolution_number__;
  global __tracking_times__;
  _particle_history.beginning_revolution = 1;
  __tracking_times__ = zeros(1,n_loop);
  for k = 1:loopstep:n_loop
    for n = k:(k+loopstep-1)
      tic();
      __revolution_number__ = n;
      for m = 1:length(span_array)
        #span_array{m}.name
        particles = span_array{m}.apply(span_array{m}, particles);
      endfor
      __tracking_times__(n) = toc();
    endfor    
    save_history(particles);
  endfor
  
  #particle_hist = setfields(_particle_history, "num", particle_rec.num);
  particle_hist = _particle_history;
  particle_hist.initial = ini_particles;
  particle_hist.revolution_number = __revolution_number__;
  particle_hist.id = __particle_id__;
  varargout{1} = particle_hist;
  if (nargout > 1)
    varargout{end+1} = track_rec;
  end

  if (nargout > 2)
    varargout{end+1} = track_rec;
  end
  
  if (!isempty(logdir))
    save("-z", [logdir,"/track_rec.mat"], "track_rec");
  endif
endfunction

function initialize_global_storages()
  global _particle_history;
  global __revolution_number__;
  has_hit = isfield(_particle_history, "hit");
  if (has_hit)
    hit_records = _particle_history.hit;
    for [val, key] = hit_records
      hit_records.(key) = {};
    endfor
  endif
  #_particle_history = struct;
  if (has_hit)
    _particle_history.hit = hit_records;
  endif
  
  if (isfield(_particle_history, "monitors"))
    for [val, key] = _particle_history.monitors
      _particle_history.monitors.(key) = cell(1, length(val));
    endfor
  endif
  _particle_history.beginning_revolution = __revolution_number__ + 1;
endfunction
  
function __dummy(varargin)
end

function __save_history(varargin)
  persistent digit;
  persistent location;
  persistent pretime = time;
  if (ischar(varargin{1}))
    [loopmax, location] = get_properties(varargin,...
                        {"loopmax", "location"}, {10000,"./"});
    digit = int2str(length(int2str(loopmax)));
    pretime = time;
    return;
  endif
  
  global _particle_history;
  global __particle_id__;
  global __revolution_number__;
  particle_hist = _particle_history;
  particle_hist.revolution_number = __revolution_number__;
  particle_hist.id = __particle_id__;
  particle_hist.last_particles = varargin{1};
  save("-z", sprintf(["%s/","%0", digit, "d.mat"],location, __revolution_number__), "particle_hist");
  initialize_global_storages();
  printf("Ended until %d turns.\n", __revolution_number__);
  printf("Spended time %d [sec]\n", time - pretime);
  pretime = time;
end  