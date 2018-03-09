## -*- texinfo -*-
## @deftypefn {Function File} {@var{retval} =} subtract(@var{cod1}, @var{cod2})
##  cod1.at_bpms - cod2.at_bpms
## or
##  cod1.kick_angles  - cod2.kick_angles
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
## 2018-02-09
## * added a function to substrat kick angles.
## 2013-11-26
## * first implementation

function cod1 = subtract(cod1, cod2)
  if isstruct(cod1.at_bpms)
    for [val, key] = cod2.at_bpms
      cod1.at_bpms.(key) -= val;
    endfor
  else
    for n = 1:length(cod1.kickers)
      if ! strcmp(cod1.kickers, cod2.kickers)
        error("kickers are not equivalent.");
      endif
    endfor
    cod1.kick_angles -= cod2.kick_angles;
  endif
endfunction