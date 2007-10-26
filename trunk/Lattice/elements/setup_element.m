## -*- texinfo -*-
## @deftypefn {Function File} {@var{new_element_rec} =} setup_element(@var{element_rec}, @var{mat_func}, @var{horv})
## 
## Append a matrix and twiss paramerter's matrix into @var{element_rec}. The matrix is obtaiened by a function handle @var{mat_func}.
##
## @var{horv} indicate horizontal "h" or vertical "v".
##
## @example
## strQ = setup_element(strQ, @QFmat, "h");
## @end example
##
## @end deftypefn

##== History
## 2007-10-26
## * renamed from buildElememntStruct

function element_rec = setup_element(element_rec, mat_func, horv)
  [len, hasEfflen] = fieldLength(element_rec);
  ## full
  element_rec.mat.(horv) = mat_func(element_rec);
  
  if (hasEfflen)
    dl = (element_rec.efflen - element_rec.len)/2;
    dlMat = DTmat(-dl);
    element_rec.mat.(horv) =  dlMat * element_rec.mat.(horv) * dlMat;
  endif
  
  element_rec.twmat.(horv) = twpMatrix(element_rec.mat.(horv));
  
  ## half
  element_rec.mat_half.(horv) = mat_func(setfield(element_rec, "efflen", len/2));
  if (hasEfflen)
    element_rec.mat_half.(horv) = dlMat * element_rec.mat_half.(horv);
  endif
  element_rec.twmat_half.(horv) = twpMatrix(element_rec.mat_half.(horv));
endfunction