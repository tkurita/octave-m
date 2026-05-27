## -*- texinfo -*-
## @deftypefn {Function File} {@var{retval} =} expected(@var{cod})
## Obtain expected result by applying COD correction @*
## i.e. measured COD (vs_positions) - fitting result (by_kickers)
## 
## @seealso{by_kickers, vs_positions}
## @end deftypefn

##== History
## 2026-05-27
## * first implementation

function cod_list = expected(cod_fit)
  a_lattice = cod_fit.ring.lattice;
  measured = vs_positions(cod_fit);
  fitxy = by_kickers(cod_fit);
  cod_list = [];
  for xy = measured'
    xy(2) = xy(2) - xy_near_x(fitxy, xy(1))(2);
    cod_list(end+1,:) = xy;
  endfor
endfunction