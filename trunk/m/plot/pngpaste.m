## -*- texinfo -*-
## @deftypefn {Function File} {@var{retval} =} pngpaste(@var{outpath})
## make a png file from clipboard data into @var{outpath}.
##
## @end deftypefn

##== History
## 2014-09-18
## * first implementation

function pngpaste(outpath)
  pngpaste_path = file_in_path(getenv("PATH"), "pngpaste")
  [err, msg] = system(sprintf("%s '%s'", pngpaste_path, outpath));
  if err != 0
    error(sprintf("Failed to pngpaste error %d : %s", err, msg));
  endif
endfunction