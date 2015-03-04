## -*- texinfo -*-
## @deftypefn {Function File} {@var{retval} =} move_points(@var{xy}, @var{dist_and_angle}, [@var{rotate_origin}])
## description
## @strong{Inputs}
## @table @var
## @item @var{xy}
## xy points. firxt column is x values, second column is y values.
## @item @var{dist_and_angle}
## A struture of distance and totaion angle
## @item @var{rotate_origin}
## @end table
##
## @strong{Outputs}
## @table @var
## @item retval
## description of @var{retval}
## @end table
##
## @end deftypefn

##== History
## 2012-02-27

function retval = move_points(xy, dist_and_angle, varargin)
  if length(varargin) > 0
    ind_origin = varargin{1};
  else
    ind_origin = 1;
  endif
  
  nrows = rows(xy);
  # 平行移動
  xy_shifted = xy + repmat(dist_and_angle.dxdy, nrows, 1);
  # ind_origin を原点に移動
  origin_to_zero_mat = repmat(xy_shifted(ind_origin, :), nrows, 1);
  xy_shifted2 = xy_shifted - origin_to_zero_mat;
  # 回転
  cos_q = dist_and_angle.cos_theta;
  sin_q = sqrt(1-cos_q^2);
  cw_mat = [cos_q, sin_q; -sin_q, cos_q];
  retval = transpose(cw_mat * xy_shifted2') + origin_to_zero_mat;
endfunction

%!test
%! move_points(x)
