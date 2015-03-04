## -*- texinfo -*-
## @deftypefn {Function File} {@var{result} =} mat_with_element(@var{element})
##
## @var{element} is a beam optics element object.
##
## Obtain 6 times 6 matrix from 'mat.h' and 'mat.v' fields of @var{element}.
## @end deftypefn

##== History
## 2007-10-04
## * initial implementation

function result = mat_with_element(an_elem)
  #an_elem
  result = [an_elem.mat.h, zeros(3); zeros(3), an_elem.mat.v ];
endfunction