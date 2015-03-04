## -*- texinfo -*-
## @deftypefn {Function File} {@var{delta_nu} =} tune_shift_sx(@var{sx_rec_list}, @var{positions_at_sx} [mm])
## 
## The unit of @var{positions_as_sx} is [mm];
##
## @end deftypefn


#shareTerm /Users/tkurita/WorkSpace/シンクロトロン/2007.10 Tracking/extraction_tracking2/extraction_tracking2.m

##== History
## 2007-10-25
## * first implementaion

function delta_nu = tune_shift_sx(sx_rec_list, positions_at_sx)
  # sx_rec_list = track_rec_pk.sextupoles
  #  load("../../2007.06-7 9MeV 入射 COD/BMPe2/session20071024"...
  #    , "cod_9201_expected")
  #  sx_names = value_for_keypath(sx_rec_list, "name", "as_cells");
  #  cod_at_sx = lookup_cod_at_elements(cod_9201_expected...
  #    , track_rec_pk.lattice, sx_names, "as_matrix");
  #  positions_at_sx = positions_at_sx(:,2)'/1000;
  positions_at_sx = positions_at_sx/1000;
  beta_h = value_for_keypath(sx_rec_list, "centerBeta.h");
  beta_v = value_for_keypath(sx_rec_list, "centerBeta.v");
  sx_strength = value_for_keypath(sx_rec_list, "strength");
  delta_nu.h = (1/(4*pi)) * sum(sx_strength.*positions_at_sx.*beta_h);
  delta_nu.v = - (1/(4*pi)) * sum(sx_strength.*positions_at_sx.*beta_v);
endfunction
