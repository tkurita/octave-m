## -- usage : strQD = QD(qk, ql, theName, varargin);

function strQD = QD(qk, ql, theName, varargin)
  hasEfflen = isstruct(ql);
  if (hasEfflen)
    strQD = ql;
  else
    strQD.len = ql;
  endif
  
  strQD.name = theName;
  strQD.k = qk;
  #strQD
  ##== horizontal
  strQD = setup_element(strQD, @QDmat, "h");
  
  ##== vertical
  strQD = setup_element(strQD, @QFmat, "v");  
  
  if (length(varargin) != 0)
    strQD.duct = ductAperture(varargin{1});
  endif
  strQD.kind = "QD";
endfunction