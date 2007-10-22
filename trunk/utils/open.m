## Usage : open(filepath)
##         
##      Open a file with Finder

## PKG_ADD: mark_as_command open

function open(filepath)
  if (nargin == 0)
    warning("No argument.");
    return
  endif
  
  system(["open '",filepath,"'"]);
endfunction