## rgb = name2rgb(colorname)
##
##   Convert color name to RGB value.
##
## Example
##   rgb = name2rgb("red")
##   -> [1, 0, 0]

function rgb = name2rgb(c)
  if ! nargin
    print_usage();
    return;
  endif
  
  switch c
    case "black"
      rgb = [0, 0, 0];
    case "red"
      rgb = [1, 0 ,0];
    case "green"
      rgb = [0, 1, 0];
    case "blue"
      rgb = [0, 0, 1];
    case "magenta"
      rgb = [1, 0, 1];
    case "cyan"
      rgb = [0, 1, 1];
    case "yellow"
      rgb = [1, 1, 0];
    case "white"
      rgb = [1, 1, 1];
    otherwise
      error(sprintf("'%s' is unknown color.", c));
  endswitch
endfunction
