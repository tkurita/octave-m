## -*- texinfo -*-
## @deftypefn {Function File} {@var{result} =} basename(@var{arg})
##
## @end deftypefn

##== History
## 2008-08-08
## * first implementaion

function retval = basename(fpath, suffix)
  # exist("suffix")
  pelems = regsplit(fpath, "/");
  retval = pelems{end};
  if (exist("suffix"))
    params = {retval};
    if (! strcmp(suffix, "*"))
      params{end+1} = suffix;
    endif
    retval = strip_suffix(params{:});
  endif
endfunction

%!test
%! basename("aaa/bb.text", "\\.text")
