
##== Hisotry
## 2009-06-24
## * deprecated.

function result = quotedForm(filename)
  warning("quotedForm is deprecated. Use quote.");
  result = ["'", filename, "'"];
endfunction
