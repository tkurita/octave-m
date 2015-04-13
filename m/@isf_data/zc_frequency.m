## -*- texinfo -*-
## @deftypefn {Function File} {@var{retval} =} zc_frequency(@var{isf_data}, [@var{diff_threshold}, @var{method}, "need_amplitude", "timerange", @var{tr}])
## @deftypefnx {Function File} {@var{retval} =} zc_frequency(@var{isf_data}, "fit"/"interp", @var{ncycle})
## @deftypefnx {Function File} {@var{checkresult} =} zc_frequency(@var{isf_data}, "fit-check", [@var{index}, [@var{ncycle}]], ["overlap", @var{overlap}])
## Evaluate frequency from peripod of zerocrossing positions.
##
## @strong{Inputs}
## @table @var
## @item diff_threshold
## When polar opposite value continues over @{diff_threshold} samples,
## the timming is considered as crossing zero.
## Pass 2 for low sampling rate or 5 for high sampling rate.
## The default value is 5.
## @item method
## @itemize
## @item "simple" : evaluate periods from porints closests to zero.
## @item "interp" : evaluate zerocrossing by linear interpolation.
## @item "minterp" : evaluate zerocrossing by linear interpolation 
##                   and evaluate frequency with multiple cycles.
##                   Synonym of "interp".
## @item "minterp-no-overlap" : evaluate zerocrossing by linear interpolation 
##                   and evaluate frequency with multiple cycles.
##                   No overlapping between frames.
## @item "fit" : sine curve fitting of one cycle. 
## @item "mfit" : sine curve fitting of multiple cycles. Synonym of "fit".
## @item "leasqr" : perform fitting using leasqr function.
## @item "leasqr-wt" : perform fitting using leasqr function with weights.
## @item "internal-variable" : obtain interval variable.
## @end itemize
##
## The default value is "iterp".
## If the input signal is not noisy, "interp" will be better result than "fit". 
## @item ncycle
## A number of cycle to fit with a sine wave.
## Large @var{ncycle} will increase computatoin time.
## @item cosine
## Pass "cosine".
## If @var{method} is "fit", phase of target signal is shifted
## about the period/2. 
## @end table
##
## @strong{Outputs}
## Return array of time vs frequency.
##
## @end deftypefn

##== History
## 2015-02-23
## * added "overlap" option.
## 2015-02-19
## * iterp accept a number to cycles for a frame.
## * added "minterp" which is synonym of "interp"
## * "miterp-no-overlap"
## * "mfit-overlap" : maximum overlap between frames.
## 2015-01-28
## * remove "plot" option. use "fit-check".
## * added mfit method.
## * added fit-check method
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
  diff_threshold = 5;
  method = "interp";
  need_amplitude = false;
  tr = [];
  target_index = [];
  ncycle = 1;
  use_cosine = false;
  samplelag = 0;
  invert = false;
  noverlap = 0;
  if (length(varargin))
    n = 1;
    while n <= length(varargin)
      opt = varargin{n};
      if isnumeric(opt)
        diff_threshold = opt;
      elseif ischar(opt)
        switch opt
          case {"simple", "fit"}
            method = opt;
          case {"mfit", "mfit-overlap", "interp", "minterp", "minterp-no-overlap",...
                "leasqr", "leasqr-wt"}
            method = opt;
            if (length(varargin) > n) && isnumeric(varargin{n+1})
              ncycle = varargin{++n};
            endif
          case "fit-check"
            method = opt;
            target_index = varargin{++n};
            if (length(target_index) > 1)
              ncycle = target_index(2);
              target_index = target_index(1);
            endif
          case "internal-variable"
            method = opt;
            varname = varargin{++n};
          case "need_amplitude"
            need_amplitude = true;
          case "timerange"
            tr = varargin{++n};
          case "cosine"
            use_cosine = true;
          case "invert"
            invert = true;
          case "overlap"
            v = varargin{++n};
            if v >= ncycle
              error("The overlap cycle %d must be less than the frame cycle %d.",...
                    v, ncycle);
            endif
          otherwise
            error([opt, " is unknown option."]);
        endswitch
      endif
      n += 1;
    endwhile
  endif
  
  nskip = ncycle - noverlap;
  v = isf.v;
  t = subsref(isf, struct("type", ".", "subs", "t"));
  xzero = str2num(isf.preambles.XZE);
  xinc = subsref(isf, struct("type", ".", "subs", "ts"));
  if !isempty(tr)
    ind = (t >= tr(1)) & (t <= tr(2));
    v = v(ind);
    t = t(ind);
    xzero = t(1);
  endif
  if invert 
    chpolar_indexes = find(v > 0);
  else
    chpolar_indexes = find(v < 0);
  endif
  ind_list = find(diff(chpolar_indexes) > diff_threshold);
  zc_indexes1 = chpolar_indexes(ind_list);
  switch method
    case {"interp", "minterp"}
      zc_indexes2 = zc_indexes1 + 1;
      v1 = v(zc_indexes1);
      v2 = v(zc_indexes2);
      zc_indexes0 = (v1.*zc_indexes2 - v2.*zc_indexes1)./(v1 - v2);
      zc_indexes_shifted = zc_indexes0(ncycle+1:end);
      zc_indexes0 = zc_indexes0(1:end-ncycle);
      tdiff = (zc_indexes_shifted - zc_indexes0)*xinc;
      period = tdiff/ncycle;
      t_zc = (zc_indexes0-1)*xinc+((ncycle*period)/2) + xzero;
      fresult = 1./period;
      tresult = t_zc;
    case "minterp-no-overlap"
      zc_indexes2 = zc_indexes1 + 1;
      v1 = v(zc_indexes1);
      v2 = v(zc_indexes2);
      zc_indexes0 = (v1.*zc_indexes2 - v2.*zc_indexes1)./(v1 - v2);
      zc_indexes0 = zc_indexes0(1:ncycle:end);
      tdiff = diff(zc_indexes0)*xinc;
      period = tdiff/ncycle;
      t_zc = (zc_indexes0(1:end-1)-1)*xinc+((ncycle*period)/2) + xzero;
      fresult = 1./period;
      tresult = t_zc;
    #== simple
    case "simple"
      period = diff(zc_indexes1)*xinc;
      t_zc = t(zc_indexes1);
      fresult = 1./period;
      tresult = t_zc(1:end-1);
    #== fit
    case {"fit", "mfit"}
      page_screen_output(0, "local");
      st = time;
      period = diff(zc_indexes1)*xinc;
      t_zc = t(zc_indexes1);
      fguess = 1./period;
      if use_cosine
        samplelag = round(period/(4*xinc));
      else
        samplelag = zeros(length(period),1);
      endif
      nmax = length(zc_indexes1)-ncycle;
      idxlist = 1:ncycle:nmax;
      nidx = length(idxlist);
      fresult = zeros(nidx, 1);
      ampresult = zeros(nidx, 1);
      m = 1;
      for n = idxlist
        yin = v(zc_indexes1(n)+samplelag(n):zc_indexes1(n+ncycle)+samplelag(n));
        tin = 0:xinc:(length(yin)-1)*xinc;
        pf = sinefit(yin, tin, fguess(n), 0, 0, 1);
        fresult(m) = pf(3);
        ampresult(m) = pf(2);
        printf("%d/%d, elapsed time : %.1f [s]\r", m, nidx, time()-st);
        m++;
      endfor
      tresult = (t_zc(idxlist) + t_zc(idxlist+ncycle))/2;
      printf("\n"); # prevent overlap between the display of elapsed time and a prompt.
    #== mfit-overlap
    case "mfit-overlap"
      period = diff(zc_indexes1)*xinc;
      t_zc = t(zc_indexes1);
      fguess = 1./period;
      fresult = [];
      ampresult = [];
      tresult = [];
      st = time;
      nmax = length(zc_indexes1)-ncycle;
      for n = nmax
        yin = v(zc_indexes1(n):zc_indexes1(n+ncycle));
        tin = 0:xinc:(length(yin)-1)*xinc;
        pf = sinefit(yin, tin, fguess(n), 0, 0, 1);
        fresult(n) = pf(3);
        ampresult(n) = pf(2);
        tresult(n) = (t_zc(n) +t_zc(n+ncycle))/2;
        printf("%d/%d, elapsed time : %.1f [s]\r", n, nmax, time()-st);
      endfor
      printf("\n"); # prevent overlap between the display of elapsed time and a prompt.
    #== leasqr
    case "leasqr"
      page_screen_output(0, "local");
      st = time;
      pkg load optim
      period = diff(zc_indexes1)*xinc;
      t_zc = t(zc_indexes1);
      fguess = 1./period;
      F = @ (x, p) p(1) + p(2)*sin(2*pi*p(3).*x + p(4));
      nmax = length(zc_indexes1)-ncycle;
      idxlist = 1:ncycle:nmax;
      nidx = length(idxlist);
      fresult = zeros(nidx, 1);
      ampresult = zeros(nidx, 1);
      tresult = zeros(nidx, 1);      
      m = 1;
      printf("start fitting\r");
      for n = idxlist
        yin = v(zc_indexes1(n):zc_indexes1(n+ncycle));
        tin = 0:xinc:(length(yin)-1)*xinc;
        pin =  [0, max(yin), fguess(n), 0];
        [yout, pout, CVG, ITER] = leasqr(tin(:), yin(:), pin, F, 1e-6, 20);
        fresult(m) = pout(3);
        ampresult(m) = pout(2);
        tresult(m) = (t_zc(n) + t_zc(n+ncycle))/2;
        printf("%d/%d, elapsed time : %.1f [s]\r", m, nidx, time()-st);
        m++;
      endfor
      printf("\n");
    #== leasqr-wt
    case "leasqr-wt"
      pkg load optim
      period = diff(zc_indexes1)*xinc;
      t_zc = t(zc_indexes1);
      fguess = 1./period;
      fresult = [];
      ampresult = [];
      tresult = [];
      F = @ (x, p) p(1) + p(2)*sin(2*pi*p(3).*x + p(4));
      page_screen_output(0, "local");
      nmax = length(zc_indexes1)-ncycle;
      m = 1;
      st = time();
      for n = 1:ncycle:nmax
        yin = v(zc_indexes1(n):zc_indexes1(n+ncycle));
        tin = 0:xinc:(length(yin)-1)*xinc;
        pin =  [0, max(yin), fguess(n), 0];
        wt = sqrt(abs(yin)).^-1;
        infind = find(isinf(wt));
        while (length(infind) > 0)
          wt(infind) = wt(infind-1);
          infind = find(isinf(wt));
        endwhile
        [yout, pout, CVG, ITER] = leasqr(tin(:), yin(:), pin, F, 1e-6, 20 ,wt);
        fresult(m) = pout(3);
        ampresult(m) = pout(2);
        tresult(m) = (t_zc(n) + t_zc(n+ncycle))/2;
        printf("%d/%d, elapsed time : %.1f [s]\r", n, nmax, time()-st);
        m++;
      endfor
      printf("\n");
    case "fit-check"
      period = diff(zc_indexes1)*xinc;
      t_zc = t(zc_indexes1);
      fguess = 1./period;
      if use_cosine
        samplelag = round(period/(4*xinc));
      endif
      fresult = [];
      ampresult = [];
      n = target_index;
      skidx = 1:nskip:length(zc_indexes1)-ncycle;
      y = v(zc_indexes1(skidx(n))+samplelag:zc_indexes1(skidx(n)+ncycle)+samplelag);
      t = 0:xinc:(length(y)-1)*xinc;
      pf = sinefit(y, t, fguess(skidx(n)), 0, 1, 1);
      f = pf(3);
      amp = pf(2);
      #plot(t, y, "*", t, pf(1) + amp.*cos(2*pi*f*t + pf(4)), "-");
      retval = tars(t, y, f, amp, pf);
      return;
    case "internal-variable"
      retval = eval(varname);
      return;
    otherwise
      error([method , " is unknown method."]);
  endswitch
  
  if need_amplitude
    retval = [tresult(:), fresult(:), ampresult(:)];
  else
    retval = [tresult(:), fresult(:)];
  endif
endfunction

%!test
%! func_n