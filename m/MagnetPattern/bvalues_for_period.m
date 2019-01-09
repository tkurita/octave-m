## -*- texinfo -*-
## @deftypefn {Function File} {[@var{blist}, @var{tlist}] =} bvalues_for_period(@var{patternSet}, @var{tstep}, @var{tstart}, @var{tend})
## @deftypefnx {Function File} {@var{tblist} =} bvalues_for_period(@var{patternSet}, @var{tstep}, @var{tstart}, @var{tend})
##
## stat points of each region are always included.
## 前後に外挿するときは、一定値とする。
##
## Parameters :
##
## @table @code
## @item @var{tstep}
## time interval [msec]
## @item @var{tstart}
## Optional
## @item @var{tend}
## Optional
## @end table
##
## Result :
##
## @table @code
## @item @var{blist}
## values genelated form @var{patternSet}. May BL [T*m] or GL [(T/m)*m].
## @item @var{tlist}
## tiems [ms]
## @item @var{tblist}
## [tlist, blist]
## @end table
## 
## @seealso{value_at_time}
## @end deftypefn

function varargout = bvalues_for_period(patternSet, varargin)
  # patternSet = BMPattern
  # timeInfo = {1,675,730}
  timeInfo = varargin;
  tstep = timeInfo{1};
  
  tpoints = patternSet{1}.tPoints;
  tlist = timeLine(tpoints,tstep);
  blist = interp_in_region(patternSet{1},tlist);
  
  nRegion = length(patternSet);
  for n = 2:nRegion
    # n = 5;
    # 
    tpoints = patternSet{n}.tPoints;
    tlist_tmp = timeLine(tpoints, tstep);
    blist_tmp = interp_in_region(patternSet{n}, tlist_tmp);
    if (length(tlist_tmp) > 0)
      if (tlist(end) == tlist_tmp(1))
        tlist_tmp = tlist_tmp(2:end);
        blist_tmp = blist_tmp(2:end);
      endif
      tlist = [tlist,tlist_tmp];
      blist = [blist,blist_tmp];
    endif
  endfor
  #plot(tlist)
  
  if (length(timeInfo) > 1)
    tstart = timeInfo{2};
    if (tlist(1) > tstart)
      headdingTime = tstart:tstep:(tlist(1)-tstep);
      tlist = [headdingTime,tlist];
      headdingB(1:length(headdingTime)) = blist(1);
      blist = [headdingB, blist];
    elseif (tlist(1) < tstart)
      n = 1;
      while(tlist(n) < tstart)
        n++;
      endwhile
      tlist = tlist(n:length(tlist));
      blist = blist(n:length(blist));
    endif
  endif
  
  if (length(timeInfo) > 2)
    tend = timeInfo{3};
    if (tlist(end) < tend)
      enddingTime = (tlist(end)+tstep):tstep:tend;
      tlist = [tlist,enddingTime];
      enddingB(1:length(enddingTime)) = blist(end);
      blist = [blist,enddingB];
    elseif (tlist(end) > tend)
      n = length(tlist)-1;
      while(tlist(n) > tend)
        n--;
      endwhile
      tlist = tlist(1:n);
      blist = blist(1:n);
    endif
    
  endif
  if nargout > 1 
    varargout = {blist(:), tlist(:)};
  else
    varargout = {[tlist(:), blist(:)]};
  endif
endfunction

function tlist = timeLine(tpoints, tstep)
  if (tstep < 1)
    tlist = (tpoints(1)+tstep):tstep:tpoints(end);
  else
    tlist = ceil(tpoints(1)):tstep:floor(tpoints(end));
  endif
  
endfunction
