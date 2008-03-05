## -*- texinfo -*-
## @deftypefn {Function File} {@var{sepatartix_info} =} values_for_separatrix(@var{track_rec}, [@var{TUNE}])
##
## Return pre-parameters for calculation of third resonance separatrix.
##
## The folling equation is used.
##
## @math{a_3n0 e^{i xi} = (sqrt(2)/(24*pi))*sum(sx_beta.^(3/2).*sx_strength.*exp(i*(3.*sx_phase - (3*tune - n0).*sx_theta)));}
##
## When the argument @var{TUNE} is ommited, @var{track_rec}.tune.h is used.
##
## The result has following fields.
##
## @table @code
## @item delta_tune
## difference of resonance tune and particle tune.
## @code{delta_tune = n0/3 - tune}
##
## @item tune
## same to @var{track_rec}.tune.h
##
## @item a_3n0
## Coupling factor ?
## 
## @item xi
## coupling_angle ?
##
## @item circumference
## The circumference of the ring.
##
## @end table
## @end deftypefn

##== History
## 2008-02-20
## * the argument tune can be a vector
## * if tune is a vector, each fields of the result struct are vectors.
## 
## 2008-02-20
## * tune can be given as an argument
##
## 2008-02-19
## * result including tune
##
## 2008-02-09
## * rename from prepare_for_separatrix into values_for_separatrix
## 
## 2007-11-02
## * add support BM fringing sextupole
##
## 2007-10-16
## * initial implementation

function separatrix_info = values_for_separatrix(varargin)
  track_rec = varargin{1};
  if (length(varargin) > 1)
    tune = varargin{2}(:);
  else
    tune = track_rec.tune.h;
  endif
  
  sx_strength = [];
  sx_positions = [];
  sx_beta = [];
  sx_phase = [];
  
  if (isfield(track_rec, "sextupoles"))
    sx_names = value_for_keypath(track_rec.sextupoles, "name", "as_cells");
    sx_strength = value_for_keypath(track_rec.sextupoles, "strength");
    sx_array = element_with_name(track_rec, sx_names);
    sx_positions = value_for_keypath(sx_array, "centerPosition");
    sx_beta = value_for_keypath(sx_array, "centerBeta.h");
    sx_phase = value_for_keypath(sx_array, "centerPhase.h");
  endif
  
  if (isfield(track_rec, "bm_sx"))
    for n = 1:length(track_rec.lattice)
      if (is_BM(track_rec.lattice{n}))
        a_bm = track_rec.lattice{n};
        sx_beta(end+1) = a_bm.entranceBeta.h;
        sx_positions(end+1) = a_bm.entrancePosition;
        sx_phase(end+1) = a_bm.entrancePhase.h;
        sx_strength(end+1) = track_rec.bm_sx;
        sx_beta(end+1) = a_bm.exitBeta.h;
        sx_positions(end+1) = a_bm.exitPosition;
        sx_phase(end+1) = a_bm.exitPhase.h;
        sx_strength(end+1) = track_rec.bm_sx;
      endif
    endfor
  endif
  
  circumference = circumference(track_rec);
  sx_theta = 2*pi.*sx_positions./circumference;

  n_sx = length(sx_beta);
  n_tune = length(tune);
  if (n_tune > 1)
    sx_theta = repmat(sx_theta, n_tune, 1);
    sx_phase = repmat(sx_phase, n_tune, 1);
    sx_strength = repmat(sx_strength, n_tune, 1);
    sx_beta = repmat(sx_beta, n_tune, 1);
  endif
  n0 = find_n0(tune, 3);
  delta_tune = tune - n0/3;
  sx_beta_32 = sx_beta.^(3/2);
  b = sx_beta_32.*sx_strength...
        .*exp(i*(3.*sx_phase - 3*repmat(delta_tune, 1, n_sx).*sx_theta));
  coupling_term = (sqrt(2)/(24*pi))*sum(b, 2);
  a_3n0 = abs(coupling_term);
  xi = angle(coupling_term);
  
  # detuning factor
#  detune_xx = 0;
#  for n = 1:length(sx_strength)
#    del_phase = abs(sx_phase(n) - sx_phase);
#    detune_xx += (sx_strength(n)*sx_strength).*(sx_beta_32(n).*sx_beta_32)...
#    .*(cos(3*(pi*tune-del_phase))/sin(3*pi*tune) + 3*cos(pi*tune - del_phase)/sin(pi*tune));
#  endfor
#  detune_xx = (1/(64*pi))*sum(detune_xx);
  
  # build result
#  separatrix_info = build_struct(tune, delta_tune, n0,  a_3n0, xi, circumference, detune_xx);
   separatrix_info = build_struct(tune, delta_tune, n0,  a_3n0, xi, circumference);
endfunction
