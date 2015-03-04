## -*- texinfo -*-
## @deftypefn {Function File} {@var{result} =} func_name(@var{arg})
##
## @end deftypefn

##== History
##

function phi = phi_with_psi(psi, element_info, sep_info)
  theta = 2*pi*element_info.position/sep_info.circumference;
  phi = psi + element_info.phase.h...
        - sep_info.delta_tune*theta...
        - sep_info.xi/3;            
endfunction