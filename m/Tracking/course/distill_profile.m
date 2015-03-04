## -*- texinfo -*-
## @deftypefn {Function File} {@var{result} =} distill_profile(@var{track_result}, @var{position})
##
## return closest profile near @var{position} [m].
##
## @var{track_result} is the result of track_course.
##
## @end deftypefn

##== History
##

function [particles, pos_for_particles] = distill_profile(track_result, position)
  pos_list = track_result.positions;
  ind = 0;
  for n = 1:length(pos_list)
    if (pos_list(n) > position)
      if ((pos_list(n) - position) > (position - pos_list(n-1)))
        ind = n;
      else
        ind = n-1;
      endif
      break;
    endif
  endfor
  particles = track_result.particles{ind};
  pos_for_particles = track_result.positions(ind);
endfunction