## -*- texinfo -*-
## @deftypefn {Function File} {@var{new_filename} =} strip_suffix(@var{filename}, @var{suffix})
##
## Remove the suffix/extension of @var{filename}.
## If @var{suffix} is specified, only suffixes which match to @var{suffix} is removed.
## @var{suffix} should be a regular expression.
##
## @example
## strip_suffix("/path1/name1.txt")
## > ans = /path1/name1
## @end example
##
## @end deftypefn


##== History
## 2008-08-08
## 
## 2007-10-22
## * renamed from stripSuffix
##
## 2007.06.01
## * version 2.9 用に書き換え

function result = strip_suffix(filename, suffix)
  #filename = "hello.dataa"
  #match = regexp(".[A-Za-z0-9]*$", filename); v 2.1
  if (exist("suffix"))
    match = regexp(filename, [suffix, "$"]);
  else
    match = regexp(filename,"\\.[A-Za-z0-9]*$");
  endif
  if (length(match))
    filename = filename(1:match(1)-1);
  endif
  result = filename;
endfunction
  
%!test
% strip_suffix("hello.dat")