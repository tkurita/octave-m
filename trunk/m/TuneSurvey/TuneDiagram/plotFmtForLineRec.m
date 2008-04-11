function fmt = plotFmtForLineRec(lineRec, varargin)
  [with_kind, colors] = get_properties(varargin, {"with_kind", "colors"}, {false, []});
  if (isempty(colors))
    colors = rgbfull(length(lineRec.resoOrder*2));
  end

  if (lineRec.x == 0)
    if (lineRec.y == 1)
      eqString = sprintf("ny = %d", lineRec.c);
    else
      eqString = sprintf("%d ny = %d", lineRec.y, lineRec.c);
    endif
    
  elseif (lineRec.y == 0)
    if (lineRec.x == 1)
      eqString = sprintf("nx = %d", lineRec.c);
    else
      eqString = sprintf("%d nx = %d", lineRec.x, lineRec.c);
    endif
    
  elseif ((lineRec.x == 1) && (lineRec.y == 1))
    eqString = sprintf("nx + ny = %d", lineRec.c);
  elseif ((lineRec.x == 1) && (lineRec.y == -1))
    eqString = sprintf("nx - ny = %d", lineRec.c);
  elseif (lineRec.x == 1)
    eqString = sprintf("nx %+d ny = %d", lineRec.y, lineRec.c);
  elseif (lineRec.y == 1)
    eqString = sprintf("%d nx + ny = %d", lineRec.x, lineRec.c);
  elseif (lineRec.y == -1)
    eqString = sprintf("%d nx - ny = %d", lineRec.x, lineRec.c);  
  else
    eqString = sprintf("%d nx %+d ny = %d", lineRec.x, lineRec.y, lineRec.c);
  endif
  
  switch(lineRec.resoOrder)
    case (1)
      color_ind = 1;
    otherwise
      color_ind = 3*lineRec.resoOrder-4;
      if (!lineRec.isNoCouple)
        if (lineRec.isSum)
          color_ind = color_ind + 1;
        else
          color_ind = color_ind + 2;
        endif
      endif
  endswitch
  
  if (with_kind)
    switch (lineRec.resoOrder)
      case (1)
        kindString = "integer ";
      case (2)
        kindString = "2nd ";
      case (3)
        kindString = "3rd ";
      otherwise
        kindString = sprintf("%dth ", lineRec.resoOrder);
    endswitch
    
    if (!lineRec.isNoCouple)
      if (lineRec.isSum)
        kindString = [kindString, "sum "];
      else
        kindString = [kindString, "diff "];
      endif
    endif
    
  else
    kindString = "";
  endif
  p_color = colors(color_ind, :);
  # fmt = ["-",sprintf("%i", color_ind), ";",kindString, eqString, ";"]
  fmt = {["-;",kindString, eqString, ";"], "color", p_color, "linewidth", 2};
endfunction