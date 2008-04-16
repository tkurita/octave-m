## -*- texinfo -*-
## @deftypefn {Function File} {} duct_aperture(@var{radius})
## @deftypefnx {Function File} {} duct_aperture(@var{x_half_width}, @var{y_half_width})
## @deftypefnx {Function File} {} duct_aperture(@var{xmax}, @var{ymin}, @var{ymax}, @var{ymin})
##
## Make a duct size aperture.
##
## The result is a structure which have following fields.
##
## @table @code
## @item xmax
## @item xmin
## @item ymax
## @item ymin
## @item radius
## If the number of arguments is only one, this field is set.
##
## @item shape
## If the number of argument is only one, this field is "circle", otherwise "rect". 
## @end table
##
## @end deftypefn

##== History
## 2008-04-17
## * returned value has "shape" field. 
## * If the shape is "circle", the returnd value has "radius" field.

function retval = duct_aperture(a_size)
  switch length(a_size)
    case 1
      retval = struct("xmax", a_size(1), "xmin", -a_size(1)... 
                              , "ymax", a_size(1), "ymin", -a_size(1)...
                              , "radius", a_size(1), "shape", "circle");
    case 2
      retval = struct("xmax", a_size(1), "xmin", -a_size(1)...
                      , "ymax", a_size(2), "ymin", -a_size(2)...
                      , "shape", "rect");
    case 4
      retval = struct("xmax", a_size(1), "xmin", a_size(2)...
                             , "ymax", a_size(3), "ymin", a_size(4)...
                             , "shape", "rect");  
    otherwise
      a_size
      error("The matrix of duct size is invalid.");
  endswitch  
endfunction
