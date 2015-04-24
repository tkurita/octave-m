## -*- texinfo -*-
## @deftypefn {Function File} {} xspan(@var{xs}, @var{xc})
## @deftypefnx {Function File} {} xspan([@var{xs}, @var{xc}])
## @deftypefnx {Function File} {[@var{xs}, @var{xc}]} = xspan()
## Set the limits of the x-axis for the current plot 
## with a span @var{xs} and a center value @var{xc}
##
## Equivalent to xlim(@var{xc} - @var{xs}/2, @var{xc} + @var{xs}/2);
##
## @end deftypefn

## $Date::                           $
## $Rev$
## $Author$

function varargout = xspan(varargin)
  switch nargin
    case 0
      xrange = xlim();
      xc = sum(xrange)/2;
      xs = diff(xrange);
      varargout = {[xs, xc]};
      return;
    case 1
      xs = varargin{1}(1);
      xc = varargin{1}(2);
    otherwise
      xs = varargin{1};
      xc = varargin{2};
  endswitch
  xlim([xc - xs/2, xc + xs/2]);
endfunction

%!test
%! func_name(x)
