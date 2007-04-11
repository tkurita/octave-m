function strDT = DT(dl,theName, varargin)
  ##== full
  strDT.len = dl; # ’·‚³
  strDT.k.h = 0;
  strDT.k.v = 0;
  strDT.name = theName; # –¼‘O
  strDT.mat.h = DTmat(dl); # ‰¡•ûŒü‚Ì matrix
  strDT.twmat.h = twpMatrix(strDT.mat.h);
  strDT.mat.v = strDT.mat.h; # c•ûŒü‚Ì matrix
  strDT.twmat.v = strDT.twmat.h;
  
  ##== half
  strDT.mat_half.h = DTmat(dl/2);
  strDT.twmat_half.h = twpMatrix(strDT.mat_half.h);
  strDT.mat_half.v = strDT.mat_half.h;
  strDT.twmat_half.v = strDT.twmat_half.h;
  
  if (length(varargin) != 0)
    strDT.duct = ductAperture(varargin{1});
  endif
  strDT.kind = "DT";
endfunction