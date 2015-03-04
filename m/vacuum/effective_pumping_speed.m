## -*- texinfo -*-
## @deftypefn {Function File} {@var{result} =} effective_pumping_speeed(@var{s}, @var{c})
##
## @table @code
## @item @var{s}
## pumping speed [m^3/s]
## @item @var{c}
## conductance [m^3/s]
## @end table
## @end deftypefn

##== History
##

function retval = effective_pumping_speed(s, c)
  retval = 1/(1/s + 1/c);
endfunction

%!test
%! func_name(x)
