## -*- texinfo -*-
## @deftypefn {Function File} {} trace_peak_spectrum(@var{specdata}, @var{f}, @var{fwidth}, @var{opts})
##
## 
## Here is a list of required arguments.
##
## @table @code
## @item @var{specdata}
## spectrum data
## @item @var{f}
## frequency close to first peak.
## @item @var{fwidth}
## width of range to search frequency.
## @end table
##
## Here is a list of labels of options.
##
## @table @code
## @item "startime"
## time to start tracing peaks.
## @item "endtime"
## time to end tracing peaks
## @item "skipfreq"
## valuse in the vector are skipped.
## @end table
##
## The result is a structure.
##
## @table @code
## @item freq
## frequency of peaks.
## @item f_index
## index of freq in @var{specdata}
## @item t
## times of frames
## @item frame
## index of frames
## @end table
##
## @end deftypefn

##== History
## 2009-06-06
## * improve algorithm to search peaks.
## * add "skipfreq" option.
##
## 2009-06-02
## * First implementation

function retval = trace_peak_spectrum(specdata, f, fwidth, varargin)
  #  f = 1.08
  #  fwidth = 0.01
  # varargin = {"starttime", 0, "endtime", 40}
  # specdata = specdata07_v;
  opts = get_properties(varargin, {"starttime", "endtime", "skipfreq"},...
                        {specdata.msec(1), specdata.msec(end)}, []);
  sindex = find(specdata.msec >= opts.starttime)(1);
  eindex = find(specdata.msec >= opts.endtime)(1);
  flist = [];
  prey = NA;
  retval.freq = NA(eindex-sindex+1,1);
  retval.t = retval.freq;
  retval.f_index = retval.freq;
  retval.frame = retval.freq;
  m = 1;
  df = 0;
  for n = sindex:eindex
    # n = sindex
    xy = frame_spectrum_at(specdata, "x", "MHz", "frame", n);
    #  xyplot(xy)
    # [maxxy, yi] = ymax(xy, "xrange", [f-fwidth, f+fwidth]);
    maxxy = NA;
    yi = NA;
    ntry = 1;
    while (isna(maxxy))
      f
      [maxxy, yi] = _find_peak(xy, f-fwidth, f+fwidth);
      if isna(yi)
        error("fail to find peak at frame %d.",n );
      endif
      if isna(maxxy)
        if (ntry > 5)
          error("fail to find peak at frame %d.",n );
        endif
        f = f+yi*fwidth
        ntry++;
      endif        
    endwhile
    
    retval.t(m) = specdata.msec(n);
    retval.frame(m) = n;
    if (isna(prey))
      prey = maxxy(2);
    else
      if (abs(maxxy(2)) < abs(prey*0.7))
        #flist(end+1,:) = [NaN, specdata.msec(n), NaN, n];
        #continue;
        maxxy(1) = NA;
        printf("skip frame %d for to small peak.\n", n);
      endif
    endif
    
    if any(abs(opts.skipfreq(:) - maxxy(1)) <= 0.0001, 1)
      maxxy(1) = NA;
      printf("skip frame %d for skipfreq\n", n);
    endif
    
    if !isna(maxxy(1))
      df = maxxy(1) -f;
      f = maxxy(1);
      prey = maxxy(2);
    endif
    #flist(end+1,:) = [f, specdata.msec(n), yi, n];
    retval.freq(m) = maxxy(1);
    retval.f_index(m) = yi;
    f = f+df;
    m ++;
    # n++
  endfor
endfunction

function varargout = _find_peak(xy, xl, xr)
  x = xy(:,1);
  sxi = find(x >= xl)(1);
  exi = find(x > xr)(1);
  xy2 = xy(sxi:exi,:);
  [max_data, iy] = ymax(xy2);
  xydiff = diff(xy2);
  if (iy == 1)
    varargout = {NA, -1};
    return;
  endif
  
  if (iy == rows(xy2))
    varargout = {NA, 1};
    return;
  endif
  
  if !((xy2(iy) < 0) && (xy2(iy-1) > 0))
    varargout = {NA, NaN};
  endif
  iy = iy+sxi-1;
  varargout = {max_data, iy};
endfunction

%!test
%! trace_peak_spectrum(x)
