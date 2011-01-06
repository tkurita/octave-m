## -*- texinfo -*-
## @deftypefn {Function File} {} DT(@var{property_struct})
## @deftypefnx {Function File} {} DT(@var{len}, @var{name} [,@var{aparture}])
##
## Make a drift tube object.
##
## @var{property_struct} must have following fields
##
## @table @code
## @item len
## @item name
## @end table
##
## The parameters when passing multiple arguments.
## @table @code
## @item @var{len}
## length of drift tube. [m]
## @item @var{name}
## name of the element
## @item @var{aparture}
## the apparture of the drift tube. Optional.
## @end table
##
## @seealso{DTmat}
##
## @end deftypefn

##== History
## 2007-11-24
## * accept a structure as an argument


#function strDT = DT(dl,theName, varargin)
function strDT = DT(varargin)
  if (length(varargin) == 1)
    if (isstruct(varargin{1}))
      strDT = varargin{1};
    else
      error("invalid argument.");
    endif
    
  else
    strDT.len = varargin{1}; # 長さ
    strDT.name = varargin{2}; # 名前
    if (length(varargin) > 2)
      strDT.duct = duct_aperture(varargin{3});
    endif
  endif    
  
  strDT.kind = "DT";
  
  ##== full
  strDT.k.h = 0;
  strDT.k.v = 0;
  strDT.mat.h = DTmat(strDT); # 横方向の matrix
  strDT.twmat.h = twp_matrix(strDT.mat.h);
  strDT.mat.v = strDT.mat.h; # 縦方向の matrix
  strDT.twmat.v = strDT.twmat.h;
  
  ##== half
  strDT.mat_half.h = DTmat(strDT.len/2);
  strDT.twmat_half.h = twp_matrix(strDT.mat_half.h);
  strDT.mat_half.v = strDT.mat_half.h;
  strDT.twmat_half.v = strDT.twmat_half.h;
  
endfunction