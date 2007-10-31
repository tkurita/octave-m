## -*- texinfo -*-
## @deftypefn {Function File} {@var{new_filename} =} strip_suffix(@var{filename}, @var{new_suffix})
##
## remove the suffix/extension of @var{filename}
##
## @example
## strip_suffix("/path1/name1.txt")
## > ans = /path1/name1
## @end example
##
## @end deftypefn

## Usage : result = strip_suffix(filename)
##          filename から拡張子を削除する
##
##= Example
## strip_suffix("/path1/name1.txt")
## > ans = /path1/name1

##== History
## 2007-10-22
## * renamed from stripSuffix
## 2007.06.01
## * version 2.9 用に書き換え

function result = strip_suffix(filename)
  #filename = "hello.dataa"
  #match = regexp(".[A-Za-z0-9]*$", filename); v 2.1
  match = regexp(filename,".[A-Za-z0-9]*$");
  if (length(match))
    filename = filename(1:match(1)-1);
  endif
  result = filename;
endfunction
  
%!test
% strip_suffix("hello.dat")