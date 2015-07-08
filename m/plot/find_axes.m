## -*- texinfo -*-
## @deftypefn {Function File} {@var{axlist} =} find_axes([@var{fh}])
## find axes objects excluding legend objects.
## @strong{Inputs}
## @table @var
## @item fh
## A figure object. If ommited, gcf will be used.
## @end table
##
## @strong{Outputs}
## @table @var
## @item axlist
## list of all axes objects is in @var{fh}.
## @end table
##
## @end deftypefn

function axlist = find_axes(varargin)
  if ((nargin > 0) && (ishandle(varargin{1})))
    h = varargin{1};
  else
    h = gcf;
  endif
  axlist = findobj(h, "type", "axes", "-not", "tag", "legend");
endfunction

%!test
%! find_axes(x)
