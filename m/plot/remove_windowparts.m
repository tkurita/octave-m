## -*- texinfo -*-
## @deftypefn {Function File} {@var{retval} =} remove_windowparts(@var{filename})
## remove window parts from a screen capture image.
## ImageMagic is required.
##
## @end deftypefn

function retval = remove_windowparts(filename)
  if ! nargin
    print_usage();
  endif
  [status, outtext] = system(["identify -format '%w %h' ", filename]);
  wh = strsplit(outtext, " ");
  switch graphics_toolkit
    case "fltk"
      bottom_margin = 22;
      top_margin = 47;
    case "qt"
      top_margin = 66;
      bottom_margin = 0;
    otherwise
      error([graphics_toolkit, " is not supprted."]);
  endswitch
  
  is_retina = system("/usr/sbin/system_profiler SPDisplaysDataType | grep 'Display Type: Retina'  > /dev/null 2>&1");
  if (is_retina == 0)
    bottom_margin *= 2;
    top_margin *=2;
  endif
  height = str2num(wh{2})- top_margin - bottom_margin;
  [retval, outtext] = system(sprintf("convert -crop %dx%d+%d+%d %s %s",...
                     str2num(wh{1}), height, 0, top_margin, filename, filename));
endfunction

%!test
%! func_name(x)
