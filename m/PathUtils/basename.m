## -*- texinfo -*-
## @deftypefn {Function File} {@var{result} =} basename(@var{path}, @var{suffix})
##
## Obtain a last path component of @var{path} removing @var{suffix}.
##
## @var{suffix} should be regular expression or wild card "*".
##
## If @var{suffix} is omited, the path extension will be remained.
##
## @end deftypefn

##== History
## 2008-11-25
## * append help text
##
## 2008-08-08
## * First implementaion

function retval = basename(fpath, suffix)
  pelems = regsplit(fpath, "/");
  if (isempty(pelems{end}))
    pelems = pelems(1:end-1);
  endif
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
%! basename("/aaa/bb.text", "\\.text")
%! basename("/aaa/bb.text", "*")
