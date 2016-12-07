## -*- texinfo -*-
## @deftypefn {Function File} {@var{retval} =} phaseshifter_curve(@var{arg})
## description
## @strong{Inputs}
## @table @var
## @item arg1
## description of @var{arg}
## @end table
##
## @strong{Outputs}
## @table @var
## @item retval
## description of @var{retval}
## @end table
##
## @end deftypefn

function retval = phaseshifter_curve(v, rad)
  if ! nargin
    print_usage();
  endif
  retval = class(tars(v, rad), "phaseshifter_curve");
endfunction
