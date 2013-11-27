## -*- texinfo -*-
## @deftypefn {Function File} {@var{retval} =} subtract(@var{cod1}, @var{cod2})
## cod1.at_bpms - cod2.at_bpms
## @strong{Inputs}
## @table @var
## @item arg1
## description of @var{arg}
## @end table
##
## @strong{Outputs}
## @table @var
## @item retval
## description of @var{retval}
## @end table
## 
## @seealso{}
## @end deftypefn

##== History
## * 2013-11-26
## first implementation

function cod1 = subtract(cod1, cod2)
  
  for [val, key] = cod2.at_bpms
    cod1.at_bpms.(key) -= val;
  endfor
endfunction