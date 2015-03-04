## -*- texinfo -*-
## @deftypefn {Function File} {@var{retval} =} phase_margin(@var{tfc})
##
## Calculate phase margin. The phase difference from -180 when the gain is 0 dB.
##
## @strong{Inputs}
## @table @var
## @item tfc
## transfer characteristics
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
## 2011-03-03
## * add errors "gain is under zero dB." and "gain is over zero dB."
## 2011-03-02
## * First implementation

function retval = phase_margin(tfc)
  db = 20*log10(tfc.mag);
  if max(db) < 0 
    error("gain is under zero dB.");
  endif
  if min(db) > 0 
    error("gain is over zero dB.");
  endif
  w = tfc.w;
  w_db0 = interp1(db, w, 0);
  retval =interp1(w, tfc.phase, w_db0) + 180;
endfunction

%!test
%! phase_margin(x)
