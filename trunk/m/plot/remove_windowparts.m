## -*- texinfo -*-
## @deftypefn {Function File} {@var{retval} =} remove_windowparts(@var{filename})
## remove window parts from a screen capture image.
##
## @end deftypefn

##== History
## 2014-11-14
## * first implementation

function retval = remove_windowparts(filename)
  if ! nargin
    print_usage();
  endif
  [status, outtext] = system(["identify -format '%w %h' ", filename])
  wh = strsplit(outtext, " ");
  bottom_margin = 20;
  top_margin = 42;
  height = str2num(wh{2})-top_margin-bottom_margin;
  printf("convert -crop %dx%d+%d+%d %s out.png\n", str2num(wh{1}), height,...
                            0, bottom_margin, filename)
  [retval, outtext] = system(sprintf("convert -crop %dx%d+%d+%d %s %s",...
                     str2num(wh{1}), height, 0, top_margin, filename, filename));
endfunction

%!test
%! func_name(x)
