## -- usage : strQF = QF(qk, ql, theName, varargin);

function strQ = QF(qk, ql, theName, varargin)
  if (isstruct(ql))
    strQ = ql;
  else
    strQ.len = ql;
  endif
  
  strQ.name = theName;
  strQ.k = qk;
  
  ##== horizontal
  strQ = buildElementStruct(strQ, @QFmat, "h");
  
  ##== vertical
  strQ = buildElementStruct(strQ, @QDmat, "v");  
  
  if (length(varargin) != 0)
    strQ.duct = ductAperture(varargin{1});
  endif
  strQ.kind = "QF";
endfunction