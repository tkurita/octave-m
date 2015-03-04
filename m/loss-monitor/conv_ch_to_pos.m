## -*- texinfo -*-
## @deftypefn {Function File} {@var{result} =} func_name(@var{arg})
##
## @end deftypefn

##== History
##

function varargout = conv_ch_to_pos(data, calib_table, lat_rec, varargin)
  # calib_table = sec4_outside_ctable;
  # varargin = {"over"}
  # data = sec4_outside;
  opt = get_properties(varargin, {"over"}, {false});
  p_ch = pos_ch_table(calib_table, lat_rec);
  if (opt.over)
    c = circumference(lat_rec);
    [val, ind] = max(diff(p_ch(:,2)) < 0);
    for n = (ind+1):rows(p_ch)
      p_ch(n,2) += c;
    end
  end
      
  p = interp1(p_ch(:,1), p_ch(:,2), data(:,1), "linear", "extrap");
  xyplot(p_ch, "@", [data(:,1), p], "-");
  if (opt.over)
    [val, ind] = max(p > c);
    ret1 = [p(ind:end) - c, data(ind:end,2)];
    ret2 = [p(1:ind-1), data(1:ind-1,2)];
    varargout = {ret1, ret2};
  else
    varargout = {[p, data(:,2)]};
  endif
endfunction
