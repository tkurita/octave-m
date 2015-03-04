## -*- texinfo -*-
## @deftypefn {Function File} {@var{result} =} vac_elements(@var{arg})
##
## @end deftypefn

##== History
##

function retval = vac_elements(ds)
  C = 33.201;
  if !nargin
    ds = 0;
  endif
  
  # name, position [m]
  retval =  {"CP1/IP1", 32.496;
              "TMP1", 32.976;
              "IG1", 33.126;
              "IP2", 1.58;
              "IP3", 4.2751;
              "IP4", 7.2252;
              "IG2", 7.3252;
              "IP5", 9.7952;
              "IP6", 12.55;
              "CP2/IP7", 15.915;
              "IG3", 16;
              "TMP2", 16.315;
              "IP8", 18.25;
              "IP9", 21.601;
              "IP10", 25.011;
              "IP11", 26.326;
              "IG4", 26.576};
   if ds
     x = cell2mat(retval(:,2)) - ds;
     x = -(x > C)*C + x;
     retval(:,2) = mat2cell(x, ones(1,rows(x)), 1);
   end
endfunction

%!test
%! func_name(x)
