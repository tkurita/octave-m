##
## calcluate area xy points exists

function area = points_area(points, varargin)
  env_iteration = 1;
  if (length(varargin) > 0)
    env_iteration = varargin{1};
  endif
  
  a_center = mean(points);
  shift_mat = repmat(a_center,rows(points),1);
  points_shifted = points - shift_mat;
  points_complex = complex(points_shifted(:,1), points_shifted(:,2));
  polar_points = [angle(points_complex), abs(points_complex)];
  [x_sorted, x_index] = sort(polar_points(:,1));
  points_sorted = polar_points(x_index, :);
  up = points_sorted(:,2);
  for n = 1:env_iteration
    [up, down] = envelope(points_sorted(:,1), up);
  endfor
  polar_env =  [points_sorted(:,1), up];
  polar_env = polar_env(!isnan(polar_env(:,2)),:);
  xy_env = [polar_env(:,2).*cos(polar_env(:,1)), polar_env(:,2).*sin(polar_env(:,1))];
  xyplot(points, ".", xy_env + shift_mat(1:rows(xy_env),:) , "-");
  
  xy_env(:,end+1) = zeros(rows(xy_env),1);
  xy_env_shifted = shift(xy_env,1);
  area = sum(cross(xy_env_shifted, xy_env)(:,3))/2;
endfunction

