## Usage : mat_rec = span_with_elements(elements)
##
##== Parameters
## * elements : a cell array of elements of a lattice
##              or a single element structure
## 
##== History
## 2007-10-03
## * don't accept cell array of cell array
## * derived from totalMatForTrack
## * add support dispersion 

function mat_rec = span_with_elements(elements)
  if (isstruct(elements))
    a_mat = mat_with_element(elements);
  else
    a_mat = eye(6);
    for n = 1:length(elements)
      a_mat = mat_with_element(elements{n}) * a_mat;
    endfor
  endif
  
  mat_rec.mat = a_mat;
  mat_rec.apply = @through_mat;
  mat_rec.name = "matrix span";
endfunction

