## -*- texinfo -*-
## @deftypefn {Function File} {@var{result} =} ip_pa_with_amp(@var{arg})
##
## @end deftypefn

##== History
##

function retval = ip_pa_with_amp(amp)
  load(file_in_loadpath("IP_140L_Torr_A.txt"));
  #load("/Users/tkurita/share/octave/m/vacuum/IP_140L_Torr_A.txt");
  #xyplot(IP_140L_Torr_A, "-*")
  torr = interp1(IP_140L_Torr_A(:,1), IP_140L_Torr_A(:,2), amp, "extrap");
  retval = torr*133.322;
endfunction

%!test
%! func_name(x)
