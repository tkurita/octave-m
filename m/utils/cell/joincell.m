## Usage : result = joincell(carray1, carray2)
##    Join two one dimendional cell arrays 
##    into flatten one dimentional cell array.

function result = joincell(carray1, carray2)
  result = {carray1{1:end}, carray2{1:end}};
endfunction