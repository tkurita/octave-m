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
## @end table
##
## @end deftypefn


function aperture_struct = duct_aperture(a_size)
  switch length(a_size)
    case 1
      aperture_struct = struct("xmax", a_size(1), "xmin", -a_size(1)... 
                      , "ymax", a_size(1), "ymin", -a_size(1));
    case 2
      aperture_struct = struct("xmax", a_size(1), "xmin", -a_size(1)...
                      , "ymax", a_size(2), "ymin", -a_size(2));
    case 4
      aperture_struct = struct("xmax", a_size(1), "xmin", a_size(2)...
                      , "ymax", a_size(3), "ymin", a_size(4));  
    otherwise
      a_size
      error("The matrix of duct size is invalid.");
  endswitch  
endfunction
