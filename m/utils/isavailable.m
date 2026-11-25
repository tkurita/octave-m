## -- retval = isavailable(arg)
##     return true if arg is not scalar NA.
##
##  * Inputs *
##    arg1 : 
##
##  * Outputs *
##    output of function
##    
##  * Exmaple *
##
##  See also: 

function retval = isavailable(v)
  if isstruct(v)
    retval = true;
  elseif iscell(v)
    retval = true;
  elseif length(v) > 1
    retval = true;
  elseif isna(v)
    retval = false;
  else
    retval = true;
  endif
endfunction
