## -*- texinfo -*-
## @deftypefn {Function File} {} particle_trace(@var{track_result}, @var{horv} [, @var{options}])
## 
## Obtain traces of individual particles from output of track_couse.
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
## 2007-11-27
## * first implementation

function tracelist = particle_trace(track_result, hrov, varargin)
  switch (hrov)
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
  for n = 1:length(varargin)
    switch (varargin{1});
      case "angle"
        ind += 1;
      case "survivor"
        survivor = true;
    end
  end
  
  tracelist = {};
  a_mat = cell2mat(track_result.particles);
  for n = 1:track_result.n
    end_pos = (length(track_result.positions)-1)*track_result.n + n;
    a_list = a_mat(ind, n:track_result.n:end_pos);
    tracelist{end+1} = [track_result.positions', a_list'*1e3];
  end
  if (survivor)
    tracelist = tracelist(:, !track_result.hit_flag(hit_ind,:));
  end
  
end
  