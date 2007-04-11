## usage : [len, isEffective (optional) ] = fieldLength(inStr)

function varargout = fieldLength(inStr)
  hasEfflen = isfield(inStr, "efflen");
  if (hasEfflen)
    len = inStr.efflen;
  else
    len = inStr.len;
  endif
  
  if (nargout > 1)
    varargout = {len, hasEfflen};
  else
    varargout = {len};
  endif
endfunction