## -*- texinfo -*-
## @deftypefn {Function File} {@var{result} =} func_name(@var{arg})
##
## @end deftypefn

##== History
##

function track_rec = scale_sx_with_perror(track_rec, dp)
  if (isfield(track_rec, "bm_sx"))
    track_rec.bm_sx = track_rec.bm_sx/(1+dp);
  endif
  
  if (isfield(track_rec, "sextupoles"))
    for n = 1:length(track_rec.sextupoles)
      track_rec.sextupoles{n}.current = track_rec.sextupoles{n}.current/(1+dp);
    endfor
  endif
  
endfunction