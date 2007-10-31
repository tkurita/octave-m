## -*- texinfo -*-
## @deftypefn {Function File} {@var{bm_rec} =} BM(@var{bmprop}, @var{name}, [@var{apartue}, "pError", @var{p_error}])
##
## Make a bending magnet object
##
## @end deftypefn

##== History
## 2007-10-24
## * mat_half が間違っている。
## * edge * BM/2 となっているが、BM/2 * edge となるべきじゃないか

function strBM = BM(bmprop, theName, varargin)
  p_error = 0;
  n = 1;
  while (n <= length(varargin))
    if (ismatrix(varargin{n}))
      ##== apertue
      strBM.duct = ductAperture(varargin{1});
    elseif (strcmp(varargin{n}, "pError"))
      n++;
      p_error = varargin{n};
    endif
    n++;
  endwhile
  
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
  strBM.edgeK.h = (tan(edgeangle)/radius)/(1 + p_error);
  
  strBM.mat.h = BMHmat(radius, bmangle, edgeangle, p_error);
  if (hasEfflen)
    strBM.mat.h = DTmat(-dl) * strBM.mat.h * DTmat(-dl);
  endif
  
  strBM.twmat.h = twpMatrix(strBM.mat.h);
  strBM.k.h = 1/radius^2;
  strBM.k.v = 0;
  
  ##=== half
  #strBM.mat_half.h = BME_H(radius,edgeangle) * BMHmat(radius, bmangle/2, 0);
  edgemat_h = BME_H(radius,edgeangle,p_error);
  mathalf_h = BMHmat(radius, bmangle/2, 0);
  strBM.mat_half.h = mathalf_h * edgemat_h;
  strBM.mat_rest.h = edgemat_h * mathalf_h;
  if (hasEfflen)
    #strBM.mat_half.h = DTmat(-dl)*strBM.mat_half.h;
    strBM.mat_half.h = strBM.mat_half.h * DTmat(-dl);
    strBM.mat_rest.h = DTmat(-dl) * strBM.mat_rest.h;
  endif
  strBM.twmat_half.h = twpMatrix(strBM.mat_half.h);
  
  ##== vertical
  ##=== full
  options = {"pError", p_error};  
  if (isfield(strBM, "vedge"))
    #edgematrix = BME_V2(radius, edgeangle, strBM.vedge);
    options{end+1} = "vedge";
    options{end+1} = strBM.vedge;
  else
    #edgematrix = BME_V(radius, edgeangle, p_error);
  endif
  
  edgematrix = BME_V(radius, edgeangle, options{:});
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
  strBM.mat_rest.v = edgematrix * DTmat(len/2);
  if (hasEfflen)
    #strBM.mat_half.v = DTmat(-dl) * strBM.mat_half.v;
    strBM.mat_half.v = strBM.mat_half.v*DTmat(-dl);
    strBM.mat_rest.v = strBM.mat_rest.v*DTmat(-dl);
  endif
  
  strBM.twmat_half.v = twpMatrix(strBM.mat_half.v);
  
  strBM.kind = "BM";
endfunction