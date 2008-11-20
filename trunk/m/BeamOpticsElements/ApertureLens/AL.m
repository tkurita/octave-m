## -*- texinfo -*-
## @deftypefn {Function File} {} AL(@var{property_struct})
## @deftypefnx {Function File} {} AL(@var{vin}, @var{E1}, @var{E2})
##
## Return an Aperture Lens Object.
##
## @table @code
## @item @var{E1}
## Field strength at upstream of the aperture. [V/m]
# @item @var{E2}
## Field strength at downstream of the aperture. [V/m]
## @item @var{vin}
## Injection Energy in [V]
## @end table
## 
## @end deftypefn

##== History
## 2008-11-19
## * First implementation

function retval = AL(varargin)
  switch length(varargin)
    case 1
      if (isstruct(varargin{1}))
         retval = varargin{1};
     else
         error("invalid argument");
      endif
    case 4
      retval = struct("vin", varargin{1},
                      "E1", varargin{2},
                      "E2", varargin{3},
                      "len", 0,
                      "name", varargin{4});
    otherwise
      error("invalid argument");
  endswitch
  e1 = retval.E1;
  e2 = retval.E2;
  vin = retval.vin;
  retval.mat.h = [1, 0, 0;
                  -(e1-e2)/(-4*vin), 1, 0;
                  0, 0, 1];
  retval.mat.v = retval.mat.h;
  retval.kind = "Apperture Lens";
endfunction

%!test
%! AL(x)
