## -*- texinfo -*-
## @deftypefn {Function File} {} is_crossing(@var{xy0}, @var{xy1}, @var{xy2})
## 
## Check crossing of the line @var{xy1}-@var{xy2} and the line @var{xy0}-0
##
## The result is a matrix of bool values. The row direction means @{xy0}.
## The column direction means a line @var{xy1}-@var{xy2}.
## 
## @end deftypefn

##== History
## 2008-04-23
## * initial implementaion

function retval = is_crossing(xy0, xy1, xy2)
  ## 行方向 -- xy0 の並び
  ## 列方向 -- 直線 xy1-xy2 の並び
  
  nl = rows(xy1);
  np = rows(xy0);
  x1 = repmat(xy1(:,1)', np, 1),
  y1 = repmat(xy1(:,2)', np, 1); 
  x2 = repmat(xy2(:,1)', np, 1); 
  y2 = repmat(xy2(:,2)', np, 1);
  x0 = repmat(xy0(:,1), 1, nl);
  y0 = repmat(xy0(:,2), 1, nl);
  dxy = xy2 - xy1;
  dx = repmat(dxy(:,1)', np, 1);
  dy = repmat(dxy(:,2)', np, 1);
  c = dx.*y1 - dy.*x1; # c/dx が直線 xy1-xy2 の切片
  det = dx.*y0 - dy.*x0;
  ## xcross, ycross : 直線 xy1-xy2 と直線 xy0-0 の交点
  xcross = c.*x0./det;
  ycross = c.*y0./det;
  ## 交点が線分 xy1-xy2 の間にあることを確かめる
  ## xy1 -> xy2 の規格化されたベクトル
  ## (dx/sqrt(dx^2 + dy^2), dy/sqrt(dx^2 + dy^2))
  ## xy1 -> (xcross, ycross) への規格化されたベクトル
  ## ( (xcross - x1)/sqrt(dx^2 + dy^2), (ycross - y1)/sqrt(dx^2 + dy^2) )
  ## この二つのベクトルの内積 dotp が 0 と 1の間にあれば良い
  dotp = ((xcross - x1).*dx + (ycross - y1).*dy)./(dx.^2 + dy.^2);
  in_xy12 = ((dotp >= 0) & (dotp <= 1)) 
  
  ## 交点が線分 0-xy0 の間にあることを確かめる。
  ## 0->xy0 の長さが 0->(xcross, ycross) の長さより大きく、
  ## 同じ方向を向いていればよい。
  ## 0->xy0 と 0->(xcross, ycross) の内積が
  ## 0->(xcross, ycross) の長さより大きければ良い
  
  in_xy00 = (x0.*xcross + y0.*ycross) >= (xcross.^2 + ycross.^2);
  retval = in_xy12 & in_xy00;
endfunction

%!test
%! xy0 = [2,0; 0,0; 0.5,0.5];
%! xy1 = [-1,-1; 1,-1; 1,1; -1,1 ];
%! xy2 = [1,-1; 1,1; -1,1; -1,-1];
%! is_crossing(xy0, xy1, xy2)