##== History
## 2008-01-16
## * change fieldLength to field_length

function result = focusingPower(inStr, horv)
  len = field_length(inStr);
  switch (inStr.kind)
    case ("QF")
      if (strcmp(horv, "h"))
        result = abs(inStr.k) * len;
      else
        result = -1 * abs(inStr.k) * len;
      endif
    case ("QD")
      if (strcmp(horv, "h"))
        result = -1*abs(inStr.k) * len;
      else
        result = abs(inStr.k) * len;
      endif
    otherwise
      result = inStr.k.(horv) * len;
  endswitch
endfunction