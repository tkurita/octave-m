## @deftypefn {Function File} {} func_name(@var{property_struct})
## @deftypefnx {Function File} {} func_name(@var{prop}, @var{name} [,@var{aparture}])
##
## Make a electrostatic deflector object
##
## @end deftypefn

##== History
## 2007-11-26
## * accepet one argument of a structure

#function esd_struct = ESD(prop, a_name, varargin)
function esd_struct = ESD(varargin)
  if (length(varargin) == 1)
    if (isstruct(varargin{1}))
      esd_struct = varargin{1};
    else
      error("Invalid argument.");
    endif
  else
    esd_struct = setfields(varargin{1}, "name", varargin{2});  
    if (length(varargin) > 2)
      if (ismatrix(varargin{3}))
        esd_struct.duct = duct_aperture(varargin{3});
      endif
    endif
    
  endif
  
  esd_struct.len = esd_struct.radius*esd_struct.angle;  
  esd_struct.mat.h = ESCylindrical_mat(esd_struct);
  esd_struct.mat.v = DTmat(esd_struct.len);
  esd_struct.kind = "ESD";
endfunction
