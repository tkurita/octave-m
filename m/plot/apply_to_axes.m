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

function retval = apply_to_axes(propname, varargin)
  if ! nargin
    print_usage();
  endif
  
  ax = find_axes(gcf);
  #findobj(gcf, "type", "axes", "tag", "");
  
  if ! isempty(regexp(propname, "^.label"))
    for a = ax(:)'
      feval(propname, a, varargin{:});
    endfor
    return
  endif
  
  if strcmp("grid", propname)
    for n = 1:length(ax)
      grid(ax(n), varargin{:});
    endfor  
  else
    for n = 1:length(ax)
      set(ax(n), propname, varargin{1});
    endfor
  endif
endfunction

%!test
%! func_name(x)
