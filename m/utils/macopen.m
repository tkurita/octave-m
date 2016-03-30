## Usage : macopen(filepath)
##         
##      Open a file with Finder

function macopen(filepath)
  if (nargin == 0)
    warning("No argument.");
    return
  endif
  
  system(["open '",filepath,"'"]);
  waitpid(0); # too remove zombie process
endfunction
