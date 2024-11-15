## Usage : [particles, last_particles, init_patricles] 
##                    = run_tracking(track_rec, particle_rec, n_loop)
## 
## obsolute. use track_ring
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
## 2007.10.03
## * separatrixTracking.m から派生。より一般化する。
## * thin lenz 近似だけをサポートする。

function varargout = run_tracking(track_rec, particle_rec, n_loop)
  warning("run_tracking is obsolete. use track_ring");
  # n_loop = 250
  specials = {};
  all_elements = track_rec.lattice;
  ##== setup sextupole magnet
  if (isfield(track_rec, "sextupoles"))
    for n = 1:length(track_rec.sextupoles)
      sx_rec = track_rec.sextupoles{n};
      [an_elem, ind_elem] = element_with_name(all_elements, sx_rec.name);
      sx_rec = join_struct(an_elem, sx_rec);
      sx_rec = setup_sx(sx_rec, track_rec.brho);
      all_elements{ind_elem} = sx_rec;
      track_rec.sextupoles{n} = sx_rec;
      #specials{end+1} = setup_sx(sx_rec, track_rec.brho);
    endfor
    #track_rec.sextupoles = specials;
  endif
  
  ##== setup kickers
  if (isfield(track_rec, "kickers"))
    #specials = [specials, track_rec.kickers];
    for n = 1:length(track_rec.kickers)
      kicker_rec = track_rec.kickers{n};
      [an_elem, ind_elem] = element_with_name(all_elements, kicker_rec.name);
      all_elements{ind_elem} = kicker_rec;
    endfor
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
    [an_elem, ind_elem] = element_with_name(all_elements, monitor_names{n});
    
    all_elements{ind_elem} = monitor_with_element(an_elem);
    _particle_history.(monitor_names{n}) = {};
  endfor
  
  ##== setup BM fringing sextupole
  if (isfield(track_rec, "bm_sx"))
    for n = 1:length(all_elements)
      if (is_BM(all_elements{n}))
        all_elements{n} = setup_fringing_sx(all_elements{n}, track_rec.bm_sx);
      endif
    endfor
  endif
  
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
    
    
    #    for m = 1:length(specials)
    #      if (strcmp(specials{m}.name, an_elem.name))
    #        if (length(a_span) > 0)
    #          span_array{end+1} = span_with_elements(a_span);
    #          a_span = {};
    #        endif
    #        
    #        span_array{end+1} = specials{m};
    #        an_elem = [];
    #        break;
    #      endif
    #    endfor
    #    
    #    if (length(an_elem) > 0)
    #      a_span{end+1} = an_elem;
    #    endif
  endfor
  
  if (length(a_span))
    span_array{end+1} = span_with_elements(a_span);
    a_span = {};
  endif
  
  ##== start tracking
  ini_particles = generate_particles(particle_rec, track_rec.lattice{end});
  
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
