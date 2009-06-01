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
## 2009-05-28
## * fix invalid result
##
## 2009-05-26
## * renamed from dnuToDeltaGL

function deltaGL = dnu_to_dgl(dnu, qf_beta, qd_beta, nq, brho)
  if (isstruct(dnu))
    dnu = [dnu.h; dnu.v];
  endif
  #nq = 4; #それぞれのQ magnet の数
  beta_mat = [qf_beta.h, -qd_beta.h;
             -qf_beta.v, qd_beta.v];

  beta_mat = (nq/(4*pi)).*beta_mat;
  delta_k = beta_mat\dnu;
#  mat = [qd_beta.v, qd_beta.h;
#        qf_beta.v, qf_beta.h];
#  delta_k = (4*pi/nq)/(qf_beta.h*qd_beta.v - qd_beta.h*qf_beta.v)*mat*dnu;
  deltaGL = delta_k * brho;
endfunction