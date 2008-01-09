## -*- texinfo -*-
## @deftypefn {Function File} {@var{dnu}=} dgl_to_dnu(@var{dgl}, @var{qf_beta}, @var{qd_beta}, @var{brho})
## Retun tune difference correspoding to GL [(T/m)*m]difference.
##
## @table @code
## @item @var{dqk} [1/(m*m)]
## a vector of [delta qfk, delta qdf]
## @item @var{qf_beta}
## @item @var{qd_beta}
## @item @var{brho}
## B*rho [T*m]
## @end table
##
## @end deftypefn

function dnu = dgl_to_dnu(dgl, qf_beta, qd_beta, brho, varargin)
  nq = 4;
  dgl = dgl(:);
  dk = dgl./brho;
  beta_mat = [qf_beta.h, -qd_beta.h;
              -qf_beta.v, qd_beta.v];
  dnu = (nq/(4*pi))*beta_mat*dk;
  
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