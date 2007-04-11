## usage : setElementNamesOnXaxis(allElements, visibleLabels, clearFlag [,yposition])
## 
## obsolute use setElementsOnPlot
## visibleLabels で名前を指定した名前の element の名前をx軸上に表示されるようにする。
## 
## = Parameters
## * visibleLabels (cell array) -- 文字列を cell とした cell array。
##              visibleLabels の cell で始まる名前の element の名前が x軸上のラベベルとして設定される。
## * clearFlag (boolean) --  if ture, clear all text before
## * yposition (number) -- vertical position of labels in graph coordinate

function setElementNamesOnXaxis(allElements, visibleLabels, clearFlag, varargin)
  if (clearFlag)
    text();
  endif
  
  if (length(varargin) > 0)
    yposition = varargin{1};
  else
    yposition = 0;
  endif
  
  for n = 1:length(allElements)
    for m = 1:length(visibleLabels)
      findAns = findstr(allElements{n}.name, visibleLabels{m},0);
      if (length(findAns) && findAns(1)==1)
        #eval(sprintf("__gnuplot_set__ label \"%s\" at %f,graph 0 rotate by 90 font \"Helvetica,10\""...
        #eval(sprintf("__gnuplot_set__ label \"%s\" at %f,graph 0 rotate by 90 "...
        #  , allElements{n}.name, allElements{n}.centerPosition));
        #text(allElements{n}.centerPosition, yposition, allElements{n}.name\
        #, "Rotation", 90, "FontName", "Helvetica", "FontSize", 10);
        text(allElements{n}.centerPosition, yposition, allElements{n}.name\
          , "Rotation", 90, "FontName", "Helvetica");
        
      endif
    endfor
  endfor
  if (automatic_replot)
    replot;
  endif
  
endfunction


