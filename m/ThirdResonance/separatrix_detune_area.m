## -*- texinfo -*-
## @deftypefn {Function File} {@var{area} =} separatrix_detune_area(@var{track_rec})
##  
## Calculate phase space area [pi*mrad*mm] third resonance separatrix considering detuning effect
##
## @var{track_rec} is a structure which must have following fields.
##
## @table @code
## @item sextupoles{n}.strength
## @item lattice
## @item tune
## @end table
## @end deftypefn

##== History
## 2008-02-09
## * use values_for_separatrix instead of prepare_for_separatrix
## 
## 2007-10-17
## * initial implementaion

function area = separatrix_detune_area(track_rec)
  sep_info = values_for_separatrix(track_rec);
  ac = 16*sep_info.detune_xx*sep_info.delta_tune/(9*sep_info.a_3n0^2);
  if (sep_info.delta_tune < 0)
    J_ufp = ((sep_info.a_3n0/sep_info.detune_xx)*(-3/4 + (3/4)*sqrt(1- ac)))^2;
  else
    J_ufp = ((sep_info.a_3n0/sep_info.detune_xx)*(3/4 - (3/4)*sqrt(1- ac)))^2;
  endif
  area = (3*sqrt(3)/2)*J_ufp*1e6/pi;
endfunction

  
