## -*- texinfo -*-
## @deftypefn {Function File} {@var{dgl} =} dnu_to_dgl(@var{dnu}, @var{beta_f}, @var{beta_d}, @var{nq}, @var{brho})
##
## @table @code
## @item @var{dnu}
## a vector, [delta nu_x, delta nu_y]
## @item @var{beta_f}
## beta function at QF. a structure. must have "h" and "v" fields.
## @item @var{beta_d}
## beta function at QD. a structure. must have "h" and "v" fields.
## @item @var{nq}
## number of each Q magnets.
## @item @var{brho}
## B [T] * rho* [m].
## @end table
##
## @end deftypefn

##== History
## 2009-05-26
## * renamed from deltaNuToDeltaGL

function deltaGL = dnu_to_dgl(deltaNu, qfBeta, qdBeta, nq, brho)
  #nq = 4; #それぞれのQ magnet の数
  beta_mat = [qfBeta.h, qdBeta.h;
             -qfBeta.v, -qdBeta.v];

  beta_mat = (nq/4*pi).*beta_mat;
  delta_k = beta_mat\deltaNu;
  deltaGL = delta_k * brho;
endfunction