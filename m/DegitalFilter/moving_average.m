## -*- texinfo -*-
## @deftypefn {Function File} {@var{retval} =} moving_average(@var{v}, @var{n})
## apply moving average
## @strong{Inputs}
## @table @var
## @item @var{v}
## column-wise matirx
## @end table
## 
## @seealso{moving_average_xy}
## @end deftypefn

function retval = moving_average(v, n)
  maf1 = ones(n,1)./n;
  maf2 = normalize_filter(hamming(n).*maf1, 0);
  retval = filter(maf2, 1, v);
endfunction