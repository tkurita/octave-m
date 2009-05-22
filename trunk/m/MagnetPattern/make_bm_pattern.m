## -*- texinfo -*-
## @deftypefn {Function File} {} make_bm_pattern(@var{bmin}, @var{bmax}, @var{bgrad}, @var{smoothstep}, @var{tstart}, [@var{tend}])
##
## @table @code
## @item @var{bmin}
## The magnetic value at flat base.
##
## @item @var{bmax}
## The magnetic value at flat top.
##
## @item @var{bgrad}
## The gradient of straight region.
##
## @item @var{smoothstep}
## The time step at smooth region
## 
## @item @var{tstart}
## The time of beginning of changing value
##
## @item @var{tend}
## The time of endding of changing value. Optional
##
## @end table
##
## @end deftypefn

##== History
## 2008-08-05
## * first implementation

function varargout = make_bm_pattern(bmin, bmax, bgrad, smoothstep, tstart, tend)
  trange1 = tstart:smoothstep:(tstart+smoothstep*2);
  b1 = cubic_sloop_base(trange1, [bmin, 0,0], [bgrad, 0]);
  
  trange2 = 0:smoothstep:(0+smoothstep*2);
  b2 = cubic_sloop_top(trange2, [bgrad, 0], [bmax, 0, 0]);
  trange2 = trange2 + trange1(end) + (b2(1) - b1(end))/bgrad;
  retval = [[trange1';trange2'], [b1'; b2']];
  
  if exist("tend", "var") 
    flipped_pattern = flipud(retval);
    flipped_pattern(:,1) *= -1;
    flipped_pattern(:,1) += tstart+tend;
    retval = [retval;flipped_pattern];
  endif
  
  if (nargout < 1)
    for n = 1:rows(retval)
      printf("%5.1f\t%7.5f\n", retval(n,1), retval(n,2));
    endfor
  else
    varargout = {retval};
  endif
endfunction

function retval = cubic_sloop_base(t, ys, ye)
  [x1, x2, x3] = div_elem(t);
  [y1, y1d, y1dd] = div_elem(ys);
  [y3d, y3dd] = div_elem(ye);
  Y = [y1; y1d; y1dd; 0; 0; 0; y3d; y3dd];
  X = [0, 0, 0, 1,  0, 0, 0, 0; # y1
       0, 0, 1, 0,  0, 0, 0, 0; # y1d
       0, 2, 0, 0,  0, 0, 0, 0; # y1dd
       (x2-x1)^3,   (x2-x1)^2, (x2-x1), 1,  0, 0, 0,  -1; # y2
       3*(x2-x1)^2, 2*(x2-x1), 1,       0,  0, 0, -1, 0;  # y2d
       6*(x2-x1),   2,         0,       0,  0, -2, 0, 0;  # y2dd
       0,           0,         0,       0,  3*(x3-x2)^2,  2*(x3-x2),  1, 0; # y3d
       0,           0,         0,       0,  6*(x3-x2),    2,          0, 0]; # y3dd
  A = X\Y;
  pp = mkpp(t, [A(1:4)';A(5:8)'] );
  retval = ppval(pp, t);
endfunction

function retval = cubic_sloop_top(t, ys, ye)
  [x1, x2, x3] = div_elem(t);
  [y1d, y1dd] = div_elem(ys);
  [y3, y3d, y3dd] = div_elem(ye);
  Y = [y1d; y1dd; 0; 0; 0; y3; y3d; y3dd];
#  X = [3*x1^2, 2*x1, 1,  0,  0,0,0,0;
#       6*x1,   2,    0,  0,  0,0,0,0;
#       x2^3,   x2^2, x2, 1,  -x2^3,   -x2^2, -x2, -1;
#       3*x2^2, 2*x2, 1,  0,  -3*x2^2, -2*x2, -1,   0;
#       6*x2,  2,     0,  0,  -6*x2,   -2*x2,  0,   0;
#       0,0,0,0,  x3^3,   x3^2, x3, 1;
#       0,0,0,0,  3*x3^2, 2*x3, 1,  0;
#       0,0,0,0,  6*x3,   2,    0,  0]
  X = [0,0,1,0,  0,0,0,0;
       0,2,0,0,  0,0,0,0;
       (x2-x1)^3,   (x2-x1)^2, (x2-x1), 1,  0,0, 0,-1;
       3*(x2-x1)^2, 2*(x2-x1), 1,       0,  0,0,-1, 0;
       6*(x2-x1),   2,         0,       0,  0,-2, 0, 0;
       0,0,0,0,  (x3-x2)^3,   (x3-x2)^2, (x3-x2), 1;
       0,0,0,0,  3*(x3-x2)^2, 2*(x3-x2), 1,  0;
       0,0,0,0,  6*(x3-x2),   2,    0,  0];
  A = X\Y;
  retval = ppval(mkpp(t, [A(1:4)'; A(5:8)']), t);
endfunction

%!test
%! bmin=0.3662; bmax=1.7067; bgrad=0.002375924; smoothstep=25;
%! tstart=35; tstop=1790;
%! make_bm_pattern(bmin, bmax, bgrad, smoothstep, tstart, tstop)