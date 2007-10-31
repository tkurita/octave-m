## -*- texinfo -*-
## @deftypefn {Function File} {@var{new_filename} =} change_suffix(@var{filename}, @var{new_suffix})
##
## change the suffix/extension of @var{filename}
##
## @example
## change_suffix("/path1/name1.txt", ".dat")
## > ans = /path1/name1.dat
## @end example
##
## @end deftypefn

##== History
## 2007-10-22
## * renamed from exchangeSuffix.m

## Usage : result = exchangeSuffix(filename)
##          filename の拡張子を変更する
##
## = Example
## exchangeSuffix("/path1/name1.txt", ".dat")
## > ans = /path1/name1.dat

function result = change_suffix(filename, new_suffix)
  result = [strip_suffix(filename), new_suffix];
endfunction

%!test
% change_suffix("hello.dat", ".txt")
  