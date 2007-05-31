## Usage : reveal(func_name)
##         reveal(full_path)
##         reveal -- reveal current directory in Finder
##      Reveal a function file, a file or current directory in Finder

## PKG_ADD: mark_as_command reveal

function reveal(func_name)
  if (nargin == 0)
    system("open ./")
    return
  endif
  
  func_path = which(func_name);
  if (strcmp(func_path, "undefined"))
    has_path_delims = findstr(func_name, "/", 0);
    if ((length(has_path_delims) > 0) && (has_path_delims(1) == 1))
      ## absolute path
      func_path = func_name;
    else
      func_path = [pwd,"/", func_name];
      ## error(sprintf("Can't find function %s", func_name));
    endif
    
  endif
  
  system(["reveal '",func_path,"'"]);
endfunction