function result = focusingPower(inStr, horv)
  len = fieldLength(inStr);
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