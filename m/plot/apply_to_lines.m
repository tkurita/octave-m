## -*- texinfo -*-
## @deftypefn {Function File} {@var{retval} =} apply_to_axes(@var{propname}, @var{value})
## change property @var{propname} of each axis object of the current figure.
## @strong{Inputs}
## @table @var
## @item propname
## property name
## @item value
## new value to set to @var{propname}.
## @end table
##
## @end table
##
## @end deftypefn

function retval = apply_to_lines(varargin)
  if ! nargin
    print_usage();
  endif
  if ishandle(varargin{1})
    ax = varargin{1};
    varargin = varargin(2:end);
  else
    ax = gca;
  endif
  
  lhs = findobj(ax, "type", "line", "tag", "");
  for lh = lhs(:)'
    set(lh, varargin{1}, varargin{2});
  endfor
endfunction

%!test
%! func_name(x)
