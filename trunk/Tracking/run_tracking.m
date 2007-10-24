#shareTerm /Users/tkurita/WorkSpace/シンクロトロン/2007.10 Tracking/extraction_tracking.m
## Usage : [particles, last_particles, init_patricles] 
##                    = run_tracking(track_rec, particle_rec, n_loop)
## 
##== Parameters
## * track_rec
##    .lattice
##    .brho
##    .pError
##    .sextupoles
##    .kickers
##
## * track_recs
##      .lattice
##      .brho
##      .isx1 -- sx1 の電流値
##      .isx2 -- sx2 の電流値
##      .isx3
##      .em.x -- x emittance 初期値 [m * rad]
##      .em.y -- y emittance 初期値 [m * rad]
##      .BMPeValues -- [BMPe1, BMPe2] の電流値
## * nParticles -- 粒子の数
## * n_loop -- 粒子をまわす回数

##== History
## 2007.10.03
## * separatrixTracking.m から派生。より一般化する。
## * thin lenz 近似だけをサポートする。

function varargout = run_tracking(track_rec, particle_rec, n_loop)
  # n_loop = 250
  specials = {};
  ##== setup sextupole magnet
  if (isfield(track_rec, "sextupoles"))
    for n = 1:length(track_rec.sextupoles)
      specials{end+1} = setup_sx(track_rec.sextupoles{n}, track_rec.brho);
      #specials{end+1} = setup_sx(track_rec.sextupoles{n}, track_rec.brho, @sx_thin_kick_nocross);
    endfor
    track_rec.sextupoles = specials;
  endif
  
  ##== setup kickers
  if (isfield(track_rec, "kickers"))
    specials = [specials, track_rec.kickers];
  endif
  
  ##== setup monitors
  if (isfield(track_rec, "monitors"))
    monitor_names = track_rec.monitors;
  else
    monitor_names = {"ESD"};
  endif
  
  global _particle_history;
  _particle_history = struct;
  for n = 1:length(monitor_names)
    specials{end+1} = monitor_with_element(...
       element_with_name(track_rec, monitor_names{n}));
    _particle_history.(monitor_names{n}) = {};
  endfor
  
  ##== build span array
  span_array = {};
  a_span = {};
  for n = 1:length(track_rec.lattice)
    an_elem = track_rec.lattice{n};
    for m = 1:length(specials)
      if (strcmp(specials{m}.name, an_elem.name))
        if (length(a_span) > 0)
          span_array{end+1} = span_with_elements(a_span);
          a_span = {};
        endif
        
        span_array{end+1} = specials{m};
        an_elem = [];
        break;
      endif
    endfor
    
    if (length(an_elem) > 0)
      a_span{end+1} = an_elem;
    endif
  endfor
  
  if (length(a_span))
    span_array{end+1} = span_with_elements(a_span);
    a_span = {};
  endif
  
  ##== start tracking
  ini_particles = generate_particles(track_rec.lattice{end}, particle_rec);
  
  particles = ini_particles;
  for n = 1:n_loop
    for m = 1:length(span_array)
      #span_array{m}.name
      particles = span_array{m}.apply(span_array{m}, particles);
    endfor
  endfor    
    
  #particle_hist = setfields(_particle_history, "num", particle_rec.num);
  particle_hist = _particle_history;
  particle_hist.initial = ini_particles;
  varargout{1} = particle_hist;
  if (nargout > 1)
    varargout{end+1} = track_rec;
  endif
  
endfunction
