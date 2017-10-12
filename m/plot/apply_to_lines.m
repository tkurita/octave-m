## -*- texinfo -*-
## @deftypefn {Function File} {} apply_to_lines(@var{propname}, @var{value})
## @deftypefnx {Function File} {} apply_to_lines(@var{HAX}, @var{propname}, @var{value})
## change property @var{propname} of each line objects in the specified axes
## @strong{Inputs}
## @table @var
## @item HAX
## A handle to an axis object. If it is omitted, gca will be used.
## @item propname
## property name
## @item value
## new value to set to @var{propname}.
## @end table
##
## @strong{Examples:}
## @example
## apply_to_lines("MarkerSize", 10);
## apply_to_lines("LineWidth", 2);
## @end example
##
## @seealso(apply_to_axes)
## @end deftypefn

function apply_to_lines(varargin)
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
