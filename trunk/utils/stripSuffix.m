## Usage : result = stripSuffix(filename)
##          filename ‚©‚çŠg’£Žq‚ðíœ‚·‚é
##
## = Example
## stripSuffix("/path1/name1.txt")
## > ans = /path1/name1

function result = stripSuffix(filename)
  #filename = "hello.dataa"
  match = regexp(".[A-Za-z0-9]*$", filename);
  if (length(match))
    filename = filename(1:match(1)-1);
  endif
  result = filename;
endfunction
  
  