## -*- texinfo -*-
## @deftypefn {Function File} {@var{retval} =} moving_average_xy(@var{xy}, @var{n})
## apply moving average to y value of @var{xy}
## @strong{Inputs}
## @table @var
## @item arg1
## description of @var{arg}
## @end table
## 
## @seealso{moving_average}
## @end deftypefn

function retval = moving_average_xy(xy, n)
  x = xy(:,1);
  y = xy(:,2);
  maf1 = ones(n,1)./n;
  maf2 = normalize_filter(hamming(n).*maf1, 0);
  y2 = filter(maf2, 1, y);
  retval = [x(n:end), y2(n:end)];
endfunction