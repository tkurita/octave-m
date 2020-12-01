## -*- texinfo -*-
## @deftypefn {Function File} {@var{retval} =} phaseshifter_polycurve(@var{arg})
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

function retval = phaseshifter_polycurve(filename)
  if ! nargin
    print_usage();
  endif
  data = load(file_in_loadpath(filename));
  rad = data(:,3);
  v = data(:,4);

  v_to_rad = polyfit(v, rad, length(v)-1);
  rad_to_v = polyfit(rad, v, length(v)-1);
  self = tars(rad, v); # for the disyplay method
  self._properties = tars(v_to_rad, rad_to_v);
  retval = class(self, "phaseshifter_polycurve");
endfunction
