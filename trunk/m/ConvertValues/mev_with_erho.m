## -*- texinfo -*-
## @deftypefn {Function File} {@var{result} =} mev_with_erho(@var{echo}, @var{particle}, @var{charge})
##
## @end deftypefn

##== History
## 2008-08-20
## * first implementation

function retval = mev_with_erho(erho, particle, charge)
  v = velocity_with_erho(erho, particle, charge);
  retval = mev_with_velocity(v, particle);
endfunction

%!test
%! mev_with_erho(x)
