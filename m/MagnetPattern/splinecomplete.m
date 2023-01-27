## Copyright (C) 2004 Tetsuro Kurita
##
## This program is free software; you can redistribute it and/or modify
## it under the terms of the GNU General Public License as published by
## the Free Software Foundation; either version 2 of the License, or
## (at your option) any later version.
##
## This program is distributed in the hope that it will be useful,
## but WITHOUT ANY WARRANTY; without even the implied warranty of
## MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
## GNU General Public License for more details.
##
## You should have received a copy of the GNU General Public License
## along with this program; if not, write to the Free Software
## Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307  USA

## -*- texinfo -*-
## @deftypefn {Function File} {@var{pp} = } csape (@var{x}, @var{y}, @var{cond}, @var{valc})
## cubic spline interpolation with various end conditions.
## creates the pp-form of the cubic spline.
##
## the following end conditions as given in @var{cond} are possible. 
## @table @asis
## @item 'complete'    
##    match slopes at first and last point as given in @var{valc}
## @item 'not-a-knot'     
##    third derivatives are continuous at the second and second last point
## @item 'periodic' 
##    match first and second derivative of first and last point
## @item 'second'
##    match second derivative at first and last point as given in @var{valc}
## @item 'variational'
##    set second derivative at first and last point to zero (natural cubic spline)
## @end table
##
## @seealso{ppval, spline}
## @end deftypefn

## Author:  Kai Habel <kai.habel@gmx.de>
## Date: 23. nov 2000
## Algorithms taken from G. Engeln-Muellges, F. Uhlig:
## "Numerical Algorithms with C", Springer, 1996

## Paul Kienzle, 19. feb 2001,  csape supports now matrix y value

function pp = splinecomplete (x, y, valc)
  
  x = x(:);
  n = length(x);
  if n < 3
    error("splinecomplete requires at least 3 points")
  endif
  
  transpose = (columns(y) == n);
  if (transpose)
    y = y';
  endif
  
  a = y;
  b = c = zeros (size (y));
  h = diff (x);
  idx = ones (columns(y),1);
  
  
  if (nargin < 3)
    valc = [0, 0];
  endif
  
  dg(2:n-1) = 2 * (h(1:n-2) + h(2:n-1));
  dg(1) = 2*h(1);
  dg(n) = 2*h(n-1);
  dg=dg';
  
  delta = diff(a)./h;
  g(2:n-1) = delta(2:n-1) - delta(1:n-2);
  g(1) = delta(1) - valc(1);
  g(n) = valc(2) - delta(n-1);
  g=g';
  
  #sigma = trisolve(dg,h,g);
  #return
  dg_len = length(dg);
  sigma = spdiags([[h(:);0],dg(:),[0;h(:)]], [-1,0,1], dg_len, dg_len)\g(:);
  
  b = delta - h.*(sigma(2:n) + 2.*sigma(1:n-1));
  c = (3 * sigma(1:n-1));
  d = (sigma(2:n) - sigma(1:n-1)) ./ h;
  a = a(1:n-1);
  
  coeffs = [d(:), c(:), b(:), a(:)];
  pp = mkpp (x, coeffs);
  
endfunction

function p = slope(delta,h,sigma,x,targetx)
  w = (targetx - x)./h;
  invw = 1 -w;
  p = delta + h ((3*w^2-1).* sigma(2:n-1) + (3*invw^2-1).* sigma(1:n-2));
endfunction

%!shared x,y,cond
%! x = linspace(0,2*pi,15)'; y = sin(x);

%!assert (ppval(csape(x,y),x), y, 10*eps);
%!assert (ppval(csape(x,y),x'), y', 10*eps);
%!assert (ppval(csape(x',y'),x'), y', 10*eps);
%!assert (ppval(csape(x',y'),x), y, 10*eps);
%!assert (ppval(csape(x,[y,y]),x), \
%!	  [ppval(csape(x,y),x),ppval(csape(x,y),x)], 10*eps)

%!test cond='complete';
%!assert (ppval(csape(x,y,cond),x), y, 10*eps);
%!assert (ppval(csape(x,y,cond),x'), y', 10*eps);
%!assert (ppval(csape(x',y',cond),x'), y', 10*eps);
%!assert (ppval(csape(x',y',cond),x), y, 10*eps);
%!assert (ppval(csape(x,[y,y],cond),x), \
%!	  [ppval(csape(x,y,cond),x),ppval(csape(x,y,cond),x)], 10*eps)

%!test cond='variational';
%!assert (ppval(csape(x,y,cond),x), y, 10*eps);
%!assert (ppval(csape(x,y,cond),x'), y', 10*eps);
%!assert (ppval(csape(x',y',cond),x'), y', 10*eps);
%!assert (ppval(csape(x',y',cond),x), y, 10*eps);
%!assert (ppval(csape(x,[y,y],cond),x), \
%!	  [ppval(csape(x,y,cond),x),ppval(csape(x,y,cond),x)], 10*eps)

%!test cond='second';
%!assert (ppval(csape(x,y,cond),x), y, 10*eps);
%!assert (ppval(csape(x,y,cond),x'), y', 10*eps);
%!assert (ppval(csape(x',y',cond),x'), y', 10*eps);
%!assert (ppval(csape(x',y',cond),x), y, 10*eps);
%!assert (ppval(csape(x,[y,y],cond),x), \
%!	  [ppval(csape(x,y,cond),x),ppval(csape(x,y,cond),x)], 10*eps)

%!test cond='periodic';
%!assert (ppval(csape(x,y,cond),x), y, 10*eps);
%!assert (ppval(csape(x,y,cond),x'), y', 10*eps);
%!assert (ppval(csape(x',y',cond),x'), y', 10*eps);
%!assert (ppval(csape(x',y',cond),x), y, 10*eps);
%!assert (ppval(csape(x,[y,y],cond),x), \
%!	  [ppval(csape(x,y,cond),x),ppval(csape(x,y,cond),x)], 10*eps)

%!test cond='not-a-knot';
%!assert (ppval(csape(x,y,cond),x), y, 10*eps);
%!assert (ppval(csape(x,y,cond),x'), y', 10*eps);
%!assert (ppval(csape(x',y',cond),x'), y', 10*eps);
%!assert (ppval(csape(x',y',cond),x), y, 10*eps);
%!assert (ppval(csape(x,[y,y],cond),x), \
%!	  [ppval(csape(x,y,cond),x),ppval(csape(x,y,cond),x)], 10*eps)
