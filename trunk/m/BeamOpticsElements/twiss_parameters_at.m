## -*- texinfo -*-
## @deftypefn {Function File} {@var{twp} =} func_name(@var{elem}, @var{pos})
##
## The accessor to obtain twiss parameters for @var{elem} at @var{pos}.
## 
## @table @code
## @item @var{elem}
## An beam optics element
## 
## @item @var{pos}
## "entrance", "center" or "exit".
##
## @end table
## 
## @end deftypefn

##== History
## 2008-06-18
## * first implementation

function retval = twiss_parameters_at(elem, pos)
  retval = elem.([pos, "Twpar"]);
endfunction