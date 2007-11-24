## @deftypefn {Function File} {@var{bm_rec} =} BM(@var{property_struct})
## @deftypefx {Function File} {@var{bm_rec} =} BM(@var{bmprop}, @var{name}, [@var{apartue}, "pError", @var{p_error}])
##
## Make a bending magnet object
##
## @end deftypefn

##== History
## 2007-10-24
## * mat_half が間違っている。
## * edge * BM/2 となっているが、BM/2 * edge となるべきじゃないか

#function bm_struct = BM(bmprop, theName, varargin)
function bm_struct = BM(varargin)
  if (length(varargin) == 1)
    if (isstruct(varargin{1}))
      bm_struct = varargin{1};
    else
      
  p_error = 0;
  n = 1;
  while (n <= length(varargin))
    if (ismatrix(varargin{n}))
      ##== apertue
      bm_struct.duct = ductAperture(varargin{1});
    elseif (strcmp(varargin{n}, "pError"))
      n++;
      p_error = varargin{n};
    endif
    n++;
  endwhile
  
  bm_struct = setfields(bmprop, "name", theName ...
                          , "len", bmprop.radius*bmprop.bmangle...
                          , "pError", p_error);
#  bm_struct = bmprop; # can be delete
#  bm_struct.name = theName;
#  bm_struct.len = bm_struct.radius*bm_struct.bmangle;
  edgeangle = bm_struct.edgeangle;
  
  hasEfflen = isfield(bm_struct, "efflen"); #effective length info exists
  ##== horizontal
  ##=== full
  bmangle = bm_struct.bmangle;
  if (hasEfflen)
    radius = bm_struct.efflen/bmangle;
    dl = (bm_struct.efflen - bm_struct.len)/2;
  else
    radius = bm_struct.radius;
  endif
  bm_struct.edgeK.h = (tan(edgeangle)/radius)/(1 + p_error);
  
  bm_struct.mat.h = BMHmat(radius, bmangle, edgeangle, p_error);
  if (hasEfflen)
    bm_struct.mat.h = DTmat(-dl) * bm_struct.mat.h * DTmat(-dl);
  endif
  
  bm_struct.twmat.h = twpMatrix(bm_struct.mat.h);
  bm_struct.k.h = 1/radius^2;
  bm_struct.k.v = 0;
  
  ##=== half
  #bm_struct.mat_half.h = BME_H(radius,edgeangle) * BMHmat(radius, bmangle/2, 0);
  edgemat_h = BME_H(radius,edgeangle,p_error);
  mathalf_h = BMHmat(radius, bmangle/2, 0);
  bm_struct.mat_half.h = mathalf_h * edgemat_h;
  bm_struct.mat_rest.h = edgemat_h * mathalf_h;
  if (hasEfflen)
    #bm_struct.mat_half.h = DTmat(-dl)*bm_struct.mat_half.h;
    bm_struct.mat_half.h = bm_struct.mat_half.h * DTmat(-dl);
    bm_struct.mat_rest.h = DTmat(-dl) * bm_struct.mat_rest.h;
  endif
  bm_struct.twmat_half.h = twpMatrix(bm_struct.mat_half.h);
  
  ##== vertical
  ##=== full
  options = {"pError", p_error};  
  if (isfield(bm_struct, "vedge"))
    #edgematrix = BME_V2(radius, edgeangle, bm_struct.vedge);
    options{end+1} = "vedge";
    options{end+1} = bm_struct.vedge;
  else
    #edgematrix = BME_V(radius, edgeangle, p_error);
  endif
  
  edgematrix = BME_V(radius, edgeangle, options{:});
  bm_struct.edgeK.v = edgematrix(2,1);
  
  if (hasEfflen)
    len = bm_struct.efflen;
  else
    len = bm_struct.len;
  endif
  
  bm_struct.mat.v = edgematrix*DTmat(len)*edgematrix;
  if (hasEfflen)
    bm_struct.mat.v = DTmat(-dl) * bm_struct.mat.v * DTmat(-dl);
  endif
  
  bm_struct.twmat.v = twpMatrix(bm_struct.mat.v);
  
  ##=== half
  #bm_struct.mat_half.v = edgematrix*DTmat(len/2);
  bm_struct.mat_half.v = DTmat(len/2) * edgematrix;
  bm_struct.mat_rest.v = edgematrix * DTmat(len/2);
  if (hasEfflen)
    #bm_struct.mat_half.v = DTmat(-dl) * bm_struct.mat_half.v;
    bm_struct.mat_half.v = bm_struct.mat_half.v*DTmat(-dl);
    bm_struct.mat_rest.v = bm_struct.mat_rest.v*DTmat(-dl);
  endif
  
  bm_struct.twmat_half.v = twpMatrix(bm_struct.mat_half.v);
  
  bm_struct.kind = "BM";
endfunction