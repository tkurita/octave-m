## -*- texinfo -*-
## @deftypefn {Function File} {@var{result} =} smooth_trapz(@var{t}, @var{ys}, @var{ye})
##
## Make pattern object of smooth trapezoidal slope.
##
## @table @code
## @item @var{t}
## A vector of 6 elemnts which indicate X points of trapezoidal slope.
## @item @var{ys}
## The first Y value
## @item @var{ye}
## The last Y value
## @end table
##
## @seealso{trapz_pattern}
##
## @end deftypefn

##== History
## 2009-05-22
## * When no arguments, execute print_usage();
## 
## 2008-08-05
## * first implementation

function varargout = smooth_trapz(t, ys, ye);
  if (nargin == 0)
    print_usage();
  endif
  if (length(t) != 6)
    error("The length of first argument must be 6.");
  endif
  
  [x1, x2, x3, x4, x5, x6] = div_elem(t);
  y1 = ys;
  y6 = ye;
  Y = [y1;0;0;  0;0;0;  0;0;0;  0;0;0;  0;0;0; y6;0;0];
  X = [0,0,0,1,  0,0,0,0,  0,0,  0,0,0,0,  0,0,0,0; # y1
       0,0,1,0,  0,0,0,0,  0,0,  0,0,0,0,  0,0,0,0; # y1d
       0,2,0,0,  0,0,0,0,  0,0,  0,0,0,0,  0,0,0,0; # y1dd
       (x2-x1)^3,   (x2-x1)^2, (x2-x1), 1,  0, 0, 0,-1,  0,0,  0,0,0,0,  0,0,0,0; # y2
       3*(x2-x1)^2, 2*(x2-x1), 1,       0,  0, 0,-1, 0,  0,0,  0,0,0,0,  0,0,0,0; # y2d
       6*(x2-x1),   2,         0,       0,  0,-2, 0, 0,  0,0,  0,0,0,0,  0,0,0,0; # y2dd
       0,0,0,0,  (x3-x2)^3,   (x3-x2)^2, (x3-x2), 1,   0,-1,  0,0,0,0,  0,0,0,0; # y3
       0,0,0,0,  3*(x3-x2)^2, 2*(x3-x2), 1,       0,  -1, 0,  0,0,0,0,  0,0,0,0; # y3d
       0,0,0,0,  6*(x3-x2),   2,         0,       0,   0, 0,   0,0,0,0,  0,0,0,0; # y3d
       0,0,0,0,  0,0,0,0,  (x4-x3), 1,  0, 0, 0,-1,  0,0,0,0; # y4
       0,0,0,0,  0,0,0,0,  1,       0,  0, 0,-1, 0,  0,0,0,0; # y4d
       0,0,0,0,  0,0,0,0,  0,       0,  0,-2, 0, 0,  0,0,0,0; # y4dd
       0,0,0,0,  0,0,0,0,  0,0,  (x5-x4)^3,   (x5-x4)^2, (x5-x4), 1,  0, 0, 0,-1; # y5
       0,0,0,0,  0,0,0,0,  0,0,  3*(x5-x4)^2, 2*(x5-x4), 1,       0,  0, 0,-1, 0;  # y5d
       0,0,0,0,  0,0,0,0,  0,0,  6*(x5-x4),   2,         0,       0,  0,-2, 0, 0;  # y5dd
       0,0,0,0,  0,0,0,0,  0,0,  0,0,0,0,  (x6-x5)^3,   (x6-x5)^2, (x6-x5), 1; # y6
       0,0,0,0,  0,0,0,0,  0,0,  0,0,0,0,  3*(x6-x5)^2, 2*(x6-x5), 1,       0; # y6d
       0,0,0,0,  0,0,0,0,  0,0,  0,0,0,0,  6*(x6-x5),   2,         0,       0]; # y6d

  A = X\Y;
  b = ppval(mkpp(t, [A(1:4)'; A(5:8)'; [0,0, A(9:10)']; A(11:14)'; A(15:18)']), t);
  if (nargout < 1)
    for n = 1:length(t)
      printf("%5.1f\t%7.5f\n", t(n), b(n));
    endfor
  else
    varargout = {b};
  endif
endfunction

%!test
%! y1 = 0.1173; y6 = 0.5635;
%! t = [35, 60, 85, 599.2, 624.2, 649.2];
%! y = smooth_trapz(t', y1, y6)
