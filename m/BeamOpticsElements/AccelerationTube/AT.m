## -*- texinfo -*-
## @deftypefn {Function File} {} AT(@var{property_struct})
## @deftypefnx {Function File} {} AT(@var{vin}, @var{e}, @var{l}, @var{name})
## @deftypefnx {Function File} {} AT(@var{ratio}, @var{l}, @var{name})
## Return an Acceleration Tube Object
##
## @table @code
## @item @var{e}
## Electrostatic field strength
##
## @item @var{vin}
## Injection Energy
##
## @item @var{ratio}
## (Final Energy)/(Injection Energy)
##
## @end table
##
## @var{property_struct} can have following fields.
## @table @code
## @item ratio
## (Final Energy)/(Injection Energy). When this field is given, 'E' and 'vin' are not required.
## @item len
## length [m]
## @item E
## Electrostatic field strength
## @item vin
## Injection Energy
## @end table
## @end deftypefn

##== History
## 2008-11-19
## * first implementation

function retval = AT(varargin)
  switch (length(varargin))
    case 1
      if (isstruct(varargin{1}))
         retval = varargin{1};
         if (!isfield(retval, "ratio"))
           retval.ratio = (retval.E*retval.len + retval.vin)/retval.vin;
         endif
     else
         error("invalid argument");
     endif
     n = retval.ratio;
     l = retval.len;
   case 3
     n = varargin{1};
     l = varargin{2};
     retval = struct("ratio", n, 
                    "len", l,
                    "name", varargin{3});
    case 4
      vin = varargin{1};
      E = varargin{2};
      l = varargin{3};
      n = (E*l+vin)/vin;
      retval = struct("ratio", n, 
                      "len", l,
                      "name", varargin{4},
                      "E", E,
                      "vin", vin);
    otherwise
      error("invalid argument");
  endswitch
  
  retval.mat.h = [1, 2*l*(sqrt(n)-1)/(n-1), 0;
                  0, 1/sqrt(n), 0;
                  0, 0, 1];
#  retval.mat.h = [1, 2*(vin/E)*(sqrt(1+E*l/vin)-1), 0;
#                  0, 1/sqrt(1+E*l/vin), 0;
#                  0, 0, 1];
  retval.mat.v = retval.mat.h;
  retval.kind = "Acceleration Tube";
endfunction

%!test
%! func_name(x)
