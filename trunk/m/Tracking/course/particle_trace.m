## -*- texinfo -*-
## @deftypefn {Function File} {} particle_trace(@var{track_result}, @var{horv} [, @var{options}])
## 
## Obtain traces of individual particles from output of track_course.
## 
## @var{options} can accept following values,
## @table @code
## @item "angle"
## @item "survior"
## @end table
##
## @seealso{track_couse}
##
## @end deftypefn

##== History
## 2008-06-23
## * improve performance
##  
## 2007-11-27
## * first implementation

function tracelist = particle_trace(track_result, horv, varargin)
  # track_result = track_out;
  # horv = "h"
  # varargin = {"survivor"}
  switch (horv)
    case "h"
      ind = 1;
      hit_ind = 1;
    case "v"
      ind = 4;
      hit_ind = 2;
    otherwise
      error "second argument must be 'h' or 'v'";
  endswitch
  
  survivor = false;
  hit = false;
  for n = 1:length(varargin)
    switch (varargin{1});
      case "angle"
        ind += 1;
      case "survivor"
        survivor = true;
      case "hit"
        hit = true;
    end
  end
  
  a_mat = arrange_cell(track_result.particles);
  tracelist = pick_history(a_mat*1000, track_result.positions(:), ind);
  if (survivor)
    tracelist = tracelist(:, !track_result.hit_flag(hit_ind,:));
  elseif (hit)
    tracelist = tracelist(:, track_result.hit_flag(hit_ind,:));
  endif
endfunction

function out = arrange_cell(a_cell)
  out = zeros(6*length(a_cell), length(a_cell{1}));
  for n = 1:length(a_cell)
    ind = 1+6*(n-1);
    out(ind:ind+5,:) = a_cell{n};
  end
end

function result = pick_history(a_mat, positions, q_index)
  nrows = rows(a_mat);
  ## x11 , x21 ...
  ## y11 , y21 ...
  ## dp11, dp21 ...
  ## x'11, x'21 ...
  ## y'11, y'21 ...
  ## dp11, dp21 ...
  ## x12 , x22 ... <-- ここから 次の position
  ## y12 , y22 ...
  ## dp12, dp22 ...
  ## x'12, x'22 ...
  ## y'12, y'22 ...
  ## dp12, dp22 ...
  ##
  ## これを
  ## x11, x21 ...
  ## x12, x22 ...
  ## と
  ## x'11, x'21 ...
  ## x'12, x'22 ...
  ## に分割

  q_list = a_mat(q_index:6:nrows,:);
  nparticles = columns(q_list); # 列の数が粒子数
#  p_list = a_mat(p_index:6:nrows,:);
  p_list = repmat(positions, 1, nparticles);
  nturns = nrows/6;
  
  ## x11, x21 ...
  ## x12, x22 ...
  ## x'11, x'21 ...
  ## x'12, x'22 ...
  ## とくっつけてから
  ## 一つ目     二つ目
  ## x11, x'11, x21, x'21 ... -- position 1
  ## x12, x'12, x22, x'22 ... -- position 1
  ## と reshape
  qp_mat = reshape([p_list; q_list], nturns, 2*nparticles);

  ## {x11, x'11; x12, x'12; ...}, 
  ## {x21, x'21; x22, x'22; ...}
  ## とセルに分割 出来上がるのは row wise
  result = mat2cell(qp_mat, [nturns], 2*ones(1,nparticles));
endfunction
