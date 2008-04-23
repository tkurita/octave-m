## -*- texinfo -*-
## @deftypefn {Function File} {} duct_aperture([@var{radius}])
## @deftypefnx {Function File} {} duct_aperture([@var{x_half_width}, @var{y_half_width}])
## @deftypefnx {Function File} {} duct_aperture([@var{xmax}, @var{ymin}, @var{ymax}, @var{ymin}])
## @deftypefnx {Function File} {} duct_aperture([@var{x1}, @var{y1}; @var{x2}, @var{y2};...])
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
## @item shape
## If the number of argument is only one, this field is "circle", otherwise "rect". 
##
## @item radius
## If the number of arguments is only one, this field is set.
##
## @item x, y
## When given shape is polygon. 
##
## @end table
##
## @end deftypefn

##== History
## 2008-04-23
## * accept poygon
## 
## 2008-04-17
## * returned value has "shape" field. 
## * If the shape is "circle", the returnd value has "radius" field.

function retval = duct_aperture(a_size)
  switch numel(a_size)
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
      if (columns(a_size) == 2)
        # polygon
        x = a_size(:,1);
        y = a_size(:,2);
        xmax = max(x);
        xmin = min(x);
        ymax = max(y);
        ymin = min(y);
        shape = "polygon";
        retval = tars(x, y, xmax, xmin, ymax, ymin, shape);
      else
        error("The matrix of duct size is invalid.");
      end
  endswitch  
endfunction
