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
## 2008-06-02
## * efflen が設定されているときの mat_half がおかしかった。
## * dlMat * element_rec.mat_half.(horv) となっていた。
##
## 2007-10-26
## * renamed from buildElememntStruct

function element_rec = setup_element(element_rec, mat_func, horv)
  [len, hasEfflen] = field_length(element_rec);
  ## full
  element_rec.mat.(horv) = mat_func(element_rec);
  
  if (hasEfflen)
    dl = (element_rec.efflen - element_rec.len)/2;
    dlMat = DTmat(-dl);
    element_rec.mat.(horv) =  dlMat * element_rec.mat.(horv) * dlMat;
  endif
  
  element_rec.twmat.(horv) = twp_matrix(element_rec.mat.(horv));
  
  ## half
  element_rec.mat_half.(horv) = mat_func(setfield(element_rec, "efflen", len/2));
  if (hasEfflen)
    element_rec.mat_half.(horv) = element_rec.mat_half.(horv) * dlMat;
  endif
  element_rec.twmat_half.(horv) = twp_matrix(element_rec.mat_half.(horv));
endfunction