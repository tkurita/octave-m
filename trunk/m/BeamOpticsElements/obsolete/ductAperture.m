## obsolete. use duct_aperture
##= functions for aperture
function ductSize = ductAperture(theSize)
  warning("ductAperture is obsolute. Use duct_aperture");
  switch length(theSize)
    case 1
      ductSize = struct("xman", theSize(1), "xmix", -theSize(1)... 
                      , "ymax", theSize(1), "ymin", -theSize(1));
    case 2
      ductSize = struct("xmax", theSize(1), "xmix", -theSize(1)...
                      , "ymax", theSize(2), "ymin", -theSize(2));
    case 4
      ductSize = struct("xmax", theSize(1), "xmix", theSize(2)...
                      , "ymax", theSize(3), "ymin", theSize(4));  
    otherwise
      theSize
      error("The matrix of duct size is invalid.");
  endswitch  
endfunction
