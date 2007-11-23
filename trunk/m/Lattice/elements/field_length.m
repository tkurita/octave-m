## usage : [len, isEffective (optional) ] = field_length(inStr)

##== History
## 2007-11-23
## * renamed from fieldLength

function varargout = field_length(inStr)
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