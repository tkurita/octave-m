## -*- texinfo -*-
## @deftypefn {Function File} plot_bucket_envelop(@var{phi_s})
##
## @var{phi_s} is a phase angle of a synchronus particle.
##
## @end deftypefn

##== History
## 2010-12-23
## * independent form RFBucketSizeLib

function plot_bucket_envelop(fs)
  # fs = pi/4
  benv = bucket_envelop(fs);

  synchronusPoint = [fs*360/(2*pi),0];
  benv(:,1) = benv(:,1)*360/(2*pi);
  xyplot(benv, "-r",...
        [benv(:,1), -benv(:,2)], "-r",...
        synchronusPoint, "-*");
  xlabel("phase angle of RF [degree]");
  ylabel("");zeroaxis();

endfunction

%!test
%! func_name(x)
