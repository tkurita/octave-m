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
## @table @code
## @item sextupoles
## @item kickers
## @item bm_sx
## S*L [1/m] Sextupole strength of BM fringing field
## @item start_elem
## @end table
##
## See generate_particles for the fields @var{particle_rec} can have.
##
## @end deftypefn


## Usage : [particles, last_particles, init_patricles] 
##                    = track_ring(track_rec, particle_rec, n_loop)
## 
##== Parameters
## * track_rec
##    .lattice
##    .brho
##    .pError
##    .sextupoles
##    .kickers
##    .bm_sx -- S*L [1/m] Sextupole strength of BM fringing field
##
## * track_recs
##      .lattice
##      .brho
## * nParticles -- 粒子の数
## * n_loop -- 粒子をまわす回数

##== History
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

function varargout = track_ring(track_rec, particle_rec, n_loop)
  
  if (isfield(track_rec, "check_hit"))
    check_hit = track_rec.check_hit;
  else
    check_hit = false;
  end
  ##== setup sextupole magnet
  track_rec = setup_sextupoles(track_rec);
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
  _particle_history = struct;

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
  
  
  ##=== setup hit checkers;
  if (check_hit)
    _particle_history.hit = struct;
    for n = 1:length(all_elements)
      an_elem = all_elements{n};
      if (is_BM(an_elem))
        all_elements{n} = {hit_checker_with_element(an_elem, "entrance")...
                           , an_elem...
                           , hit_checker_with_element(an_elem, "exit")};
      elseif (is_Qmag(all_elements{n}))
        all_elements{n} = { half_element(an_elem, true)...
                           , hit_checker_with_element(an_elem)...
                           , half_element(an_elem, false)};

      elseif (strcmp(an_elem.name, "ESD"))
        #an_elem.name
        all_elements{n} = {hit_checker_with_element(an_elem, "entrance"),an_elem};
      endif
    end
    all_elements = flat_cell(all_elements);
  end  

  
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
    _particle_history.(monitor_names{n}) = cell(1, n_loop);
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
  __tracking_times__ = zeros(1,n_loop);
  for n = 1:n_loop
    tic();
    __revolution_number__ = n;
    for m = 1:length(span_array)
      #span_array{m}.name
      particles = span_array{m}.apply(span_array{m}, particles);
    endfor
    __tracking_times__(n) = toc();
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
  
endfunction
