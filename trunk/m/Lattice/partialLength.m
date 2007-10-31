## usage: c = partialLength(allElements, [beginElement], endElement)
##
## beginElement から endElement までの周長を計算する。
## beginElement および endElement を含む。
## allElements で beginElement より endElement が先にあっても OK
## 
## = Parameters
## * beginElement -- 始まりの element 名
## * endElement -- 終わりの element 名


function c = partialLength(allElements, varargin)
  endElement = varargin{end};
  c = 0;
  beginIndex = 1;
  nElements = length(allElements);
  isBeginExist = length(varargin) > 1;
  if (isBeginExist)
    beginElement = varargin{1};
    for i = 1:nElements
      if (strcmp(allElements{i}.name, beginElement))
        beginIndex = i;
        break;
      endif      
    endfor
  endif
  
  isEndFound = false;
  for i = beginIndex:nElements
    c += allElements{i}.len;
    if (strcmp(allElements{i}.name, endElement))
      isEndFound = true;
      break;
    endif
  endfor
  
  if (!isEndFound)
    if (isBeginExist)
      for i = 1:nElements
        c += allElements{i}.len;
        if (strcmp(allElements{i}.name, endElement))
          isEndFound = true;
          break;
        endif
      endfor
      if (!isEndFound)
        error ("can't find element %s", endElement);
      endif
      
    else
      error ("can't find element %s", endElement);
    endif
  endif
  
endfunction