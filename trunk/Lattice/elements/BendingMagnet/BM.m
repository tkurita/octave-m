## Usage : strBM = BM(bmprop, theName, varargin)
##
## object of bending magnet

##== History
## 2007-10-24
## * mat_half が間違っている。
## * edge * BM/2 となっているが、BM/2 * edge となるべきじゃないか

function strBM = BM(bmprop, theName, varargin)
  strBM = bmprop;
  strBM.name = theName;
  strBM.len = strBM.radius*strBM.bmangle;
  edgeangle = strBM.edgeangle;
  
  hasEfflen = isfield(strBM, "efflen"); #effective length info exists
  ##== horizontal
  ##=== full
  bmangle = strBM.bmangle;
  if (hasEfflen)
    radius = strBM.efflen/bmangle;
    dl = (strBM.efflen - strBM.len)/2;
  else
    radius = strBM.radius;
  endif
  strBM.edgeK.h = tan(edgeangle)/radius;
  
  strBM.mat.h = BMHmat(radius, bmangle, edgeangle);
  if (hasEfflen)
    strBM.mat.h = DTmat(-dl) * strBM.mat.h * DTmat(-dl);
  endif
  
  strBM.twmat.h = twpMatrix(strBM.mat.h);
  strBM.k.h = 1/radius^2;
  strBM.k.v = 0;
  
  ##=== half
  #strBM.mat_half.h = BME_H(radius,edgeangle) * BMHmat(radius, bmangle/2, 0);
  strBM.mat_half.h = BMHmat(radius, bmangle/2, 0)*BME_H(radius,edgeangle);
  if (hasEfflen)
    #strBM.mat_half.h = DTmat(-dl)*strBM.mat_half.h;
    strBM.mat_half.h = strBM.mat_half.h * DTmat(dl);
  endif
  strBM.twmat_half.h = twpMatrix(strBM.mat_half.h);
  
  ##== vertical
  ##=== full
  if (isfield(strBM, "vedge"))
    edgematrix = BME_V2(radius,edgeangle,strBM.vedge);
  else
    edgematrix = BME_V(radius,edgeangle);
  endif
  strBM.edgeK.v = edgematrix(2,1);
  
  if (hasEfflen)
    len = strBM.efflen;
  else
    len = strBM.len;
  endif
  
  strBM.mat.v = edgematrix*DTmat(len)*edgematrix;
  if (hasEfflen)
    strBM.mat.v = DTmat(-dl) * strBM.mat.v * DTmat(-dl);
  endif
  
  strBM.twmat.v = twpMatrix(strBM.mat.v);
  
  ##=== half
  #strBM.mat_half.v = edgematrix*DTmat(len/2);
  strBM.mat_half.v = DTmat(len/2) * edgematrix;
  if (hasEfflen)
    #strBM.mat_half.v = DTmat(-dl) * strBM.mat_half.v;
    strBM.mat_half.v = strBM.mat_half.v*DTmat(-dl);
  endif
  
  strBM.twmat_half.v = twpMatrix(strBM.mat_half.v);
  
  ##== apertue
  if (length(varargin) != 0)
    strBM.duct = ductAperture(varargin{1});
  endif
  
  strBM.kind = "BM";
endfunction