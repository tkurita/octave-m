## Usage : mi(filepath)
##         
##      Open a file with mi

function mi(filepath)
  if (nargin == 0)
    
    return
  endif
  
  system(["open -a mi '",filepath,"'"]);
endfunction