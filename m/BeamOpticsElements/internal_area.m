## -*- texinfo -*-
## @deftypefn {Function File} {@var{result} =} internal_area(@var{element})
## 
## Calc internal area of beam duct.
## 
## @end deftypefn

##== History
## 2010-06-22
## * first implementation

function retval = internal_area(elem)
  cross_section = elem.duct;
  switch cross_section.shape
    case "rect"
      dx = cross_section.xmax - cross_section.xmin;
      dy = cross_section.ymax - cross_section.ymin;
      retval = (2*dx+2*dy)*elem.len;
    case "circle"
      d = 2*cross_section.radius;
      retval = 2*pi*d*elem.len;
    otherwise
      error("unknown shape.");
  endswitch
endfunction

%!test
%! func_name(x)
