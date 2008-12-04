## -*- texinfo -*-
## @deftypefn {Function File} {@var{result} =} trapz_pattern(@var{arg})
##
## @seealso{smooth_trapz}
##
## @end deftypefn

##== History
##

function retval = trapz_pattern(t, fb, ft)
  if (length(t) != 14)
    error("The length of first argument is 14.");
  endif
  y = smooth_trapz(t(2:7), fb, ft);
  y = [y(1);y(:);flipud(y(:));y(1)];
  pattern_cells = {t(1), y(1), "linear";
                   t(2), y(2), "spline";
                   t(3), y(3), "";
                   t(4), y(4), "linear";
                   t(5), y(5), "spline";
                   t(6), y(6), "";
                   t(7), y(7), "linear";
                   t(8), y(8), "spline";
                   t(9), y(9), "";
                   t(10), y(10), "linear";
                   t(11), y(11), "spline";
                   t(12), y(12), "";
                   t(13), y(13), "linear";
                   t(14), y(14), 0};
  retval = build_pattern(pattern_cells);
  #plot_bpattern(retval, "")
endfunction

%!test
%! fb = 0.1173; ft = 0.5635;
%! t = [0;35;60;85;625.4 ;650.4 ;675.4 ;1149.6 ;1174.6 ;1199.6 ;1740;1765;1790;2000];
%! y = trapz_pattern(t', ft, fb)

