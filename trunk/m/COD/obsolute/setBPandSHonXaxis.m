## Usage : setBPandSHonXaxis(allElements, position, [units])
##
## STH と BPM で始まる名前の element の名前をx軸上に表示されるようにする。
##
## Obsolete. Use elements_on_plot
## 
##== Parameters
## * position(1) -- BPM の位置
## * position(2) -- STH, BMPe の位置
## * position(3) -- 垂直ステアラの位置
## * units -- optional, "data"(default) , "normalized" or "screnn"
##

function setBPandSHonXaxis(allElements, position, varargin)
  warning("setBPandSHonXaxis is obsolete. Use elements_on_plot.");
  text();
  bmpes = {"BMPe1","BMPe2"};
  verticalSteerers = {"STV1","QD2","QD3","SM"};
  units = "data";
  if (length(varargin) > 0)
    units = varargin{1};
  endif
  
  for n = 1:length(allElements)
    currentName = allElements{n}.name;
    
    ## BPM
    findAns = findstr(allElements{n}.name, "BPM",0);
    if (length(findAns) && findAns(1)==1)
      #eval(sprintf("gset label \"%s\" at %f,%f rotate by 90 font \"Helvetica,10\"",\
      #allElements{n}.name, allElements{n}.centerPosition,position(1)));
      #      text('Position',[allElements{n}.centerPosition,position(1)],
      #      'Units','data',
      #      'Rotation',90,
      #      'String',allElements{n}.name);
      plottext(allElements{n}, position(1), units);
      continue;
    endif
    
    ## STH and BMPe
    findAns = findstr(allElements{n}.name, "STH",0);
    
    if ((length(findAns) == 0)||(findAns(1)!=1))
      ## BMPe
      for m = 1:length(bmpes)
        theName = bmpes{m};
        findAns = strcmp(currentName, theName);
        if (findAns)
          break;
        endif
      endfor
      
    endif
    
    if (length(findAns) && findAns(1)==1)
      #eval(sprintf("__gnuplot_set__ label \"%s\" at %f,%f rotate by 90 font \"Helvetica,10\""...
      #      eval(sprintf("__gnuplot_set__ label \"%s\" at %f,%f rotate by 90 "...
      #        , currentName, allElements{n}.centerPosition,position(2)));
      plottext(allElements{n}, position(2), units);
      continue;
    endif
    
    
    ## vertical steerers
    for m = 1:length(verticalSteerers)
      theName = verticalSteerers{m};
      findAns = strcmp(currentName, theName);
      if (findAns)
        break;
      endif
    endfor
    if (length(findAns) && findAns(1)==1)
      plottext(allElements{n}, position(3), units);
      continue;
    endif
  endfor
#  if (automatic_replot)
#    replot;
#  endif  
endfunction

function plottext(theElement, position, units)
  text("Position", [theElement.centerPosition, position]...
    , "Units", units...
    , "Rotation", 90 ...
    , "String",theElement.name);
endfunction  
  