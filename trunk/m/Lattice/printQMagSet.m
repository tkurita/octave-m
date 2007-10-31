## usage : [formatedText =] printQMagSet(rec)
##

function varargout = printQMagSet(rec)
  qMag.f_comment = sprintf("QF : %g",rec.qfSet);
  qMag.d_comment = sprintf("QD : %g",rec.qdSet);
  if (nargout > 0)
    varargout = {[qMag.f_comment;qMag.d_comment]};
  else
    printf("%s\n", qMag.f_comment);
    printf("%s\n", qMag.d_comment);
  endif
endfunction
