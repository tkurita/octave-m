## -*- texinfo -*-
## @deftypefn {Function File} {@var{result} =} hits_for_locations(@var{hit_history}, @var{track_rec})
##
## @var{hit_history} is the result of arrange_hits
##
## @end deftypefn

##== History
##

function hit_rec = hits_for_locations(hit_history, track_rec)
  hit_rec.mat = struct("total", [], "right", [], "left", [], "top", [], "bottom", []);
  hit_rec.names = {};
  for [val, key] = hit_history
    # key = "BMD1OUT_exit"
    # val = hit_history.(key);
    if (!isempty(val))
      [sp, ep, te, m, t, nm] = regexp(key, "(_entrance|_exit|_center)");
      if (sp)
        elem_name = key(1:sp-1);
        pos_kind = key(sp+1:end);
      else
        elem_name = key;
        pos_kind = "center";
      endif
      elem = element_with_name(track_rec, elem_name);
      pos = elem.([pos_kind, "Position"]);
      count = length(val.id);
      hit_rec.mat.total(end+1, :) = [pos, count];
      hit_rec.names{end+1} = key;
    endif
  endfor
endfunction