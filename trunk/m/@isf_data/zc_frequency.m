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
## 2012-10-18
## * first implementaion

function retval = func_name(isf, varargin)
  diff_threshold = 2;
  use_iterp = true;
  if (length(varargin))
    for n = 1:length(varargin)
      opt = varargin{n};
      if isnumeric(opt)
        diff_threshold = opt;
      elseif ischar(opt) && strcmp(opt, "simple")
        use_iterp = false;
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
  if use_iterp
    zc_indexes2 = zc_indexes1 + 1;
    v1 = v(zc_indexes1);
    v2 = v(zc_indexes2);
    zc_indexes0 = (v1.*zc_indexes2 - v2.*zc_indexes1)./(v1 - v2);
    period = diff(zc_indexes0)*xinc;
    t_zc = (zc_indexes0-1)*xinc;
  else
    period = diff(zc_indexes1)*xinc;
    t_zc = (zc_indexes1 -1) *xinc;
  endif
  retval = [t_zc(1:end-1)(:), (1./period)(:)];
endfunction

%!test
%! func_name(x)