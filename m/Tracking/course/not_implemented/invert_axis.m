## -*- texinfo -*-
## @deftypefn {Function File} {@var{result} =} invert_axis(@var{arg})
##
## @end deftypefn

##== History
## 2008-08-11
## * first

function particles = invert_axis(prop, particles)
  m = repmat([-1;-1;1], 2, columns(particles));
  particles = particles.*m;
  global _invert_state;
  _invert_state = prop.state;
endfunction

%!test
%! invert_axis(x)
