## -*- texinfo -*-
## @deftypefn {Function File} {@var{retval} =} zc_frequency(@var{isf_data}, [@var{diff_threshold}, @var{method}, "need_amplitude", "timerange", @var{tr}])
## @deftypefnx {Function File} {} zc_frequency(@var{isf_data}, "fit", "plot", @var{pltnum})
## Evaluate frequency from peripod of zerocrossing positions.
##
## @strong{Inputs}
## @table @var
## @item diff_threshold
## pass 2 for low sampling rate or 5 for high sampling rate.
## The default value is 2.
## @item method
## "simple" : evaluate periods from porints closests to zero.
## "intep" : evaluate zerocrossing by linear interpolation.
## "fit" : evaluate zerocrossing by sin curve fitting.
## The default value is "iterp"
## @item pltnum
## A list of indexes to plot fitting result.
## This option must be used with "plot" method.
## If this option is passed, result will not be returned.
## @end table
##
## @strong{Outputs}
## Return array of time vs frequency.
##
## @end deftypefn

##== History
## 2014-12-17
## * added "timerange" option.
## * added "plot" option.
## 2014-12-08
## * use struct instead of dict.
## 2013-01-08
## * taking XZE into accounts.
## 2012-10-18
## * first implementaion

function retval = zc_frequency(isf, varargin)
  diff_threshold = 2;
  method = "interp";
  need_amplitude = false;
  tr = [];
  plt = [];
  if (length(varargin))
    n = 1;
    while n <= length(varargin)
      opt = varargin{n};
      if isnumeric(opt)
        diff_threshold = opt;
      elseif ischar(opt)
        switch opt
          case {"simple", "interp", "fit"}
            method = opt;
          case "need_amplitude"
            need_amplitude = true;
          case "timerange"
            tr = varargin{++n};
          case "plot"
            plt = varargin{++n};
          otherwise
            error([opt, " is unknown option."]);
        endswitch
      endif
      n += 1;
    endwhile
  endif

  v = isf.v;
  t = subsref(isf, struct("type", ".", "subs", "t"));
  xzero = str2num(isf.preambles.("XZE"));
  xinc = str2num(isf.preambles.("XIN"));
  if !isempty(tr)
    ind = (t >= tr(1)) & (t <= tr(2));
    v = v(ind);
    t = t(ind);
    xzero = t(1);
  endif
  positive_indexes = find(v > 0);
  indexes_diff = diff(positive_indexes);
  ind_list = find(diff(positive_indexes) > diff_threshold);
  zc_indexes1 = positive_indexes(ind_list);
  switch method
    case "interp"
      zc_indexes2 = zc_indexes1 + 1;
      v1 = v(zc_indexes1);
      v2 = v(zc_indexes2);
      zc_indexes0 = (v1.*zc_indexes2 - v2.*zc_indexes1)./(v1 - v2);
      period = diff(zc_indexes0)*xinc;
      t_zc = (zc_indexes0-1)*xinc + xzero;
      fresult = 1./period;
    case "simple"
      period = diff(zc_indexes1)*xinc;
      t_zc = t(zc_indexes1);
      fresult = 1./period;
    case "fit"
      period = diff(zc_indexes1)*xinc;
      t_zc = t(zc_indexes1);
      fguess = 1./period;
      fresult = [];
      ampresult = [];
      if !isempty(plt)
        for n = plt
          yin = v(zc_indexes1(n):zc_indexes1(n+1));
          tin = 0:xinc:(length(yin)-1)*xinc;
          pf = sinefit(yin, tin, fguess(n), 0, 1, 1);
          fresult(n) = pf(3);
          ampresult(n) = pf(2);
#          plot(tin, yin, "*", tin, -pf(2).*sin(2*pi*pf(3)*tin), "-");
          input("hit a key to continue");
        endfor
        return;
      else
        for n = 1:length(zc_indexes1)-1
          yin = v(zc_indexes1(n):zc_indexes1(n+1));
          tin = 0:xinc:(length(yin)-1)*xinc;
          pf = sinefit(yin, tin, fguess(n), 0, 0, 1);
          fresult(n) = pf(3);
          ampresult(n) = pf(2);
        endfor
      endif
    otherwise
      error([method , " is unknown method."]);
  endswitch
  
  if need_amplitude
    retval = [t_zc(1:end-1)(:), fresult(:), ampresult(:)];
  else
    retval = [t_zc(1:end-1)(:), fresult(:)];
  endif
endfunction

%!test
%! func_name(x)
