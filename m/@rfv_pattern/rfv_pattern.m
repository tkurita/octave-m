## -*- texinfo -*-
## @deftypefn {Function File} {@var{retval} =} rfv_pattern(@var{pattern_data})
## Obtain rfv_pattern object.
## @strong{Inputs}
## @table @var
## @item pattern_data
## row wise matrix. first row is time interval. second row is voltage.
## @end table
##
## @end deftypefn

function retval = rfv_pattern(pattern_data)
  if ! nargin
    print_usage();
  endif
  
  retval = class(struct("pattern", pattern_data), "rfv_pattern");
endfunction

%!test
%! func_name(x)
