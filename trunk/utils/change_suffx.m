## -*- texinfo -*-
## @deftypefn {Function File} {@var{new_filename} =} change_suffix(@var{filename}, @var{new_suffix})
##
## change the suffix/extension of @var{filename}
##
## @example
## exchangeSuffix("/path1/name1.txt", ".dat")
## > ans = /path1/name1.dat
## @end example
##
## @end deftypefn


## Usage : result = exchangeSuffix(filename)
##          filename の拡張子を変更する
##
## = Example
## exchangeSuffix("/path1/name1.txt", ".dat")
## > ans = /path1/name1.dat

function result = change_suffix(filename, new_suffix)
  result = [strip_suffix(filename), new_suffix];
endfunction
  
  