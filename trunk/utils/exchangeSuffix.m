## Usage : result = exchangeSuffix(filename)
##          filename �̊g���q��ύX����
##
## = Example
## exchangeSuffix("/path1/name1.txt", ".dat")
## > ans = /path1/name1.dat

function result = exchangeSuffix(filename, newSuffix)
  result = [stripSuffix(filename), newSuffix];
endfunction
  
  