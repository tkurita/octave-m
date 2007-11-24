## usage : [len, isEffective (optional) ] = fieldLength(inStr)
## obsolete. use field_length.m

##== History
## 2007-11-23
## * obsolete

function varargout = fieldLength(inStr)
  warning("fieldLength is obsolete. Use field_length");
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