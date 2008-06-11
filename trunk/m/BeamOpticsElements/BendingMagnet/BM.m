## -*- texinfo -*-
## @deftypefn {Function File} {@var{bm_rec} =} BM(@var{property_struct})
## @deftypefnx {Function File} {@var{bm_rec} =} BM(@var{bmprop}, @var{name}, [@var{apartue}, "pError", @var{p_error}])
##
## Make a bending magnet object
##
## @var{bmprop} is a structure which have following fields.
## @table @code
## @item bmangle
## [rad]. Angle of bending magnet.
## @item radius
## [m]. radius of beam axis.
## @item edgeangle
## [rad] edge angle.
## @item efflen
## [m] effective length. Optional.
## @end table
##
## @end deftypefn

##== History
## 2008-06-02
## * edgeK の符号が逆になっていた。
## * chromaticity の計算がおかしくなる。
## 
## 2007-11-25
## * accept one argument of a structure
##
## 2007-10-24
## * mat_half が間違っている。
## * edge * BM/2 となっているが、BM/2 * edge となるべきじゃないか

#function bm_struct = BM(bmprop, theName, varargin)
function bm_struct = BM(varargin)
  if (length(varargin) == 1)
    if (isstruct(varargin{1}))
      bm_struct = varargin{1};
    else
      error("Invalid arguments");
    endif
    
  else
    bmprop = varargin{1};
    bm_struct = setfields(bmprop, "name", varargin{2} ...
      , "pError", 0);
    n = 3;
    while (n <= length(varargin))
      if (ismatrix(varargin{n}))
        ##== apertue
        bm_struct.duct = duct_aperture(varargin{n});
      elseif (strcmp(varargin{n}, "pError"))
        n++;
        bm_struct.pError = varargin{n};
      endif
      n++;
    endwhile
  endif
  
  bm_struct.len = bm_struct.radius*bm_struct.bmangle;
  hasEfflen = isfield(bm_struct, "efflen"); #effective length info exists
  ##== horizontal
  ##=== full
  if (hasEfflen)
    radius = bm_struct.efflen/bm_struct.bmangle;
    dl = (bm_struct.efflen - bm_struct.len)/2;
  else
    radius = bm_struct.radius;
  endif
  #bm_struct.edgeK.h = (tan(bm_struct.edgeangle)/radius)/(1 + bm_struct.pError);
  
  [bm_struct.mat.h,  bm_struct.edgeK.h] = BMHmat(setfields(bm_struct, "radius", radius));
  if (hasEfflen)
    bm_struct.mat.h = DTmat(-dl) * bm_struct.mat.h * DTmat(-dl);
  endif
  
  bm_struct.twmat.h = twpMatrix(bm_struct.mat.h);
  bm_struct.k.h = 1/radius^2;
  bm_struct.k.v = 0;
  
  ##=== half
  edgemat_h = BME_H(radius, bm_struct.edgeangle, bm_struct.pError);
  mathalf_h = BMHmat(radius, bm_struct.bmangle/2, 0);
  bm_struct.mat_half.h = mathalf_h * edgemat_h;
  bm_struct.mat_rest.h = edgemat_h * mathalf_h;
  if (hasEfflen)
    bm_struct.mat_half.h = bm_struct.mat_half.h * DTmat(-dl);
    bm_struct.mat_rest.h = DTmat(-dl) * bm_struct.mat_rest.h;
  endif
  bm_struct.twmat_half.h = twpMatrix(bm_struct.mat_half.h);
  
  ##== vertical
  ##=== full
  options = {"pError", bm_struct.pError};  
  if (isfield(bm_struct, "vedge"))
    #edgematrix = BME_V2(radius, edgeangle, bm_struct.vedge);
    options{end+1} = "vedge";
    options{end+1} = bm_struct.vedge;
  else
    #edgematrix = BME_V(radius, edgeangle, p_error);
  endif
  
  edgematrix = BME_V(radius, bm_struct.edgeangle, options{:});
  bm_struct.edgeK.v = -1*edgematrix(2,1);
  
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
  bm_struct.mat_half.v = DTmat(len/2) * edgematrix;
  bm_struct.mat_rest.v = edgematrix * DTmat(len/2);
  if (hasEfflen)
    bm_struct.mat_half.v = bm_struct.mat_half.v*DTmat(-dl);
    bm_struct.mat_rest.v = bm_struct.mat_rest.v*DTmat(-dl);
  endif
  
  bm_struct.twmat_half.v = twpMatrix(bm_struct.mat_half.v);
  
  bm_struct.kind = "BM";
endfunction