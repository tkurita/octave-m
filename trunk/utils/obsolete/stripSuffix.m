## Usage : result = stripSuffix(filename)
##          filename から拡張子を削除する
##
##= Example
## stripSuffix("/path1/name1.txt")
## > ans = /path1/name1

##= History
## 2007.06.01
## * version 2.9 用に書き換え

function result = stripSuffix(filename)
  #filename = "hello.dataa"
  #match = regexp(".[A-Za-z0-9]*$", filename); v 2.1
  match = regexp(filename,".[A-Za-z0-9]*$");
  if (length(match))
    filename = filename(1:match(1)-1);
  endif
  result = filename;
endfunction
  
%!test
% stripSuffix("hello.dat")