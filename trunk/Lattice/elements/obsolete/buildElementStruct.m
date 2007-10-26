## -- usage : inStr = buildElementStruct(inStr, matFunc, horv)
## obsolete. Use setup_elememnt

function inStr = buildElementStruct(inStr, matFunc, horv)
  warning("buildElementStruct is obsolete. Use setup_element");
  [len, hasEfflen] = fieldLength(inStr);
  ## full
  inStr.mat.(horv) = matFunc(inStr);
  
  if (hasEfflen)
    dl = (inStr.efflen - inStr.len)/2;
    dlMat = DTmat(-dl);
    inStr.mat.(horv) =  dlMat * inStr.mat.(horv) * dlMat;
  endif
  
  inStr.twmat.(horv) = twpMatrix(inStr.mat.(horv));
  
  ## half
  inStr.mat_half.(horv) = matFunc(setfield(inStr, "efflen", len/2));
  if (hasEfflen)
    inStr.mat_half.(horv) = dlMat * inStr.mat_half.(horv);
  endif
  inStr.twmat_half.(horv) = twpMatrix(inStr.mat_half.(horv));
endfunction