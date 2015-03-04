## -*- texinfo -*-
## @deftypefn {Function File} {@var{result} =} split_spectrum(@var{arg})
##
## @end deftypefn

##== History
## 2009-06-02
## * First Implementation

function retval = split_spectrum(specdata, tracedata)
  # tracedata = peaktrace1
#  t = specdata.msec;
#  f = specdata.MHz;
#  stind = find(t >= tracedata(1,1));
#  etind = find(t > tracedata(end,1));
#  z = specdata.dBm;
#  region_l = {};
#  region_h = {};
#  for n = 1:rows(tracedata)
#    region_l{end+1} = z(tracedata(n,4), 1:tracedata(n,3)-1);
#    region_h{end+1} = z(tracedata(n,4), 1:tracedata(n,3)+1);
#  endfor
#  [f(1:tracedata(n,3)-1)(:), region_l{1}(:)]
#  xyplot([[f(1:tracedata(1,3)-1)(:), region_l{1}(:)]; NaN, NaN])
  findmin = min(tracedata.f_index);
  findmax = max(tracedata.f_index);
  flen = length(tracedata.f_index);
  tlen = length(tracedata.t);
  specleft.MHz = specdata.MHz(1:findmax-1);
  specleft.msec = tracedata.t;
  specleft.dBm = NA(tlen, length(specleft.MHz));
  
  specright.MHz = specdata.MHz(findmin:end);
  specright.msec = tracedata.t;
  specright.dBm = NA(tlen, length(specright.MHz));
  m = 1;
  for n = tracedata.frame(1):tracedata.frame(end)
    fi = tracedata.f_index(m)-1;
    specleft.dBm(m,1:fi-1) = specdata.dBm(n, 1:fi-1);
    specright.dBm(m,fi-findmin+2:end) = specdata.dBm(n, fi+1:end);
    m++;
  endfor
  retval = {specleft, specright};
endfunction

%!test
%! split_spectrum(specdata, peaktrace1)
