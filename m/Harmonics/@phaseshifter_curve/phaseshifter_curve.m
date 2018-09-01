## -*- texinfo -*-
## @deftypefn {Function File} {@var{retval} =} phaseshifter_curve(@var{v}, @var{rad})
## make phaseshifter_curve object with array of voltages @var{v} and array of angles @var{rad}.
## 
## The methods 'rad_for_v' and 'v_for_rad' can be used to obtain corresponding values betwee @var{v} and @var{rad}. 'interp1' is utilized for linear interpolation.
##
## @strong{Inputs}
## @table @var
## @item v
## Array of voltages.
## @item rad
## Array of angles.
## @end table
##
## @end deftypefn

function retval = phaseshifter_curve(v, rad)
  if ! nargin
    print_usage();
  endif
  retval = class(tars(v, rad), "phaseshifter_curve");
endfunction
