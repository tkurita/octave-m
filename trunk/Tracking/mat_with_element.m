##== History
## 2007-10-04
## * initial implementation

function result = mat_with_element(an_elem)
  #an_elem
  result = [an_elem.mat.h, zeros(3); zeros(3), an_elem.mat.v ];
endfunction