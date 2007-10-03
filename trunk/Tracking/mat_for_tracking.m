## Usage : mat_rec = mat_for_tracking(elements)
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

function mat_rec = mat_for_tracking(elements)
  if isstruct(elements)
    a_mat = mat_with_elememnt(elements)
  else
    a_mat = eye(6);
    for n = 1:length(elements)
      a_mat = a_mat * mat_with_elememnt(elements{n})
    endfor
  endif
  
  mat_rec.mat = a_mat;
  mat_rec.apply = @through_mat;
  mat_rec.name = "matrix span";
endfunction

