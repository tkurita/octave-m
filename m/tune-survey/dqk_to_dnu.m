## -*- texinfo -*-
## @deftypefn {Function File} {@var{dnu}=} dqk_to_dnu(@var{dqk}, @var{qf_beta}, @var{qd_beta})
## Retun tune difference correspoding to qk difference.
##
## @table @code
## @item @var{dqk} [1/(m*m)]
## a vector of [delta qfk, delta qdf]
## @item @var{qf_beta}
## @item @var{qd_beta}
## @end table
##
## @end deftypefn

function dnu = dqk_to_dnu(dqk, qf_beta, qd_beta, varargin)
  nq = 4;
  qlength = 0.21;
  dqk = dqk(:);
  beta_mat = [qf_beta.h, -qd_beta.h;
              -qf_beta.v, qd_beta.v];
  dnu = (nq/(4*pi))*beta_mat*(dqk*qlength);
  n = 1;
  as_struct = false;
  while (length(varargin) >= n)
    if (strcmp(varargin{n}, "as_struct"))
      as_struct = true;
    end
    n++;
  end
  if (as_struct)
    dnu = struct("h", dnu(1), "v", dnu(2));
  end
end