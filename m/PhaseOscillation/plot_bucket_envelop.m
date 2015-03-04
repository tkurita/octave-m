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
  clf
  # fs = pi - pi/4
  benv = bucket_envelop(fs);

  synchronusPoint = [fs*360/(2*pi),0];
  benv(:,1) = benv(:,1)*360/(2*pi);
  if (fs < pi/2)
    ind1 = 1;
    ind2 = find(benv(:,1) > (pi-fs)*360/(2*pi))(1) -1;
  else
    ind1 = find(benv(:,1) < (pi-fs)*360/(2*pi))(end);
    ind2 = rows(benv);
  endif
  patch(benv(ind1:ind2,1), benv(ind1:ind2,2), "c", "edgecolor", "c");
  patch(benv(ind1:ind2,1), -1*benv(ind1:ind2,2), "c", "edgecolor", "c");
  hold on
  xyplot(benv, "-r",...
        [benv(:,1), -benv(:,2)], "-r",...
        synchronusPoint, "-*");
  hold off
  xlabel("phase angle of RF [degree]");
  ylabel("");
  hline(0);
  if fs > pi/2
    vline(90)
    vline(180)
  else
    vline(0);
    vline(90);
  endif
zeroaxis();

endfunction

%!test
%! func_name(x)
