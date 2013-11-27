## -*- texinfo -*-
## @deftypefn {Function File} {@var{retval} =} zc_frequency(@var{isf_data}, [@var{diff_threshold}, @var{method})
## Evaluate frequency from peripod of zerocrossing positions.
##
## @strong{Inputs}
## @table @var
## @item diff_threshold
## pass 2 for low sampling rate or 5 for high sampling rate.
## The default value is 2.
## @item method
## "simple" cause evaluate periods from porints closests to zero.
## "intep" cause evaluate zerocrossing by linear interpolation.
## The default value is "iterp"
## @end table
##
## @strong{Outputs}
## Return array of time vs frequency.
##
## @end deftypefn

##== History
## 2013-01-08
## * taking XZE into accounts.
## 2012-10-18
## * first implementaion

function retval = zc_frequency(isf, varargin)
  diff_threshold = 2;
  #use_iterp = true;
  method = "interp";
  need_amplitude = false;
  if (length(varargin))
    for n = 1:length(varargin)
      opt = varargin{n};
      if isnumeric(opt)
        diff_threshold = opt;
      elseif ischar(opt)
        switch opt
          case {"simple", "interp", "fit"}
            method = opt;
          case "need_amplitude"
            need_amplitude = true;
          otherwise
            error([opt, " is unknown option."]);
        endswitch
      endif
    endfor
  endif
  # diff_threshold
  v = isf.v;
  positive_indexes = find(v > 0);
  indexes_diff = diff(positive_indexes);
  ind_list = find(diff(positive_indexes) > diff_threshold);
  xinc = str2num(isf.preambles("XIN"));
  zc_indexes1 = positive_indexes(ind_list);
  xzero = str2num(isf.preambles("XZE"));
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
      t_zc = (zc_indexes1 -1) *xinc + xzero;
      fresult = 1./period;
    case "fit"
      period = diff(zc_indexes1)*xinc;
      t_zc = (zc_indexes1 -1) *xinc + xzero;
      fguess = 1./period;
      fresult = [];
      ampresult = [];
      for n = 1:length(zc_indexes1)-1
        yin = v(zc_indexes1(n):zc_indexes1(n+1));
        tin = 0:xinc:(length(yin)-1)*xinc;
        pf = sinefit(yin, tin, fguess(n), 0, 0, 1);
        fresult(n) = pf(3);
        ampresult(n) = pf(2);
      endfor
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
