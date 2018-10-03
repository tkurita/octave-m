## [xy_out, p] = polycurve_xy(x, y, n)
## [xy_out, p] = polycurve_xy(xy, n)
##
## Evaluate a polynominal curve for the xy data 
## 
## == Input
## - x, y, xy, : data to evaluate polynominal curve.
## - n : degree of a polynominal.
##
## == Output
## - xy_out : evaluated polynominal 'p' at at 'x'.
## - p : coefficients of a polynomial.

function [xy, p] = polycurve_xy(varargin)
  switch length(varargin)
      case 2
        x = varargin{1}(:,1);
        y = varargin{1}(:,2);
        n = varargin{2};
      case 3
        x = varargin{1}(:);
        y = varargin{2}(:);
        n = varargin{3};
      otherwise
        usage();
        return;
  endswitch
  p = polyfit(x, y ,n);
  y2 = polyval(p, x);
  xy = [x, y2];
endfunction

%!test
%! func_name(x)
