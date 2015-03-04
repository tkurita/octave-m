## ceil を使う
function result =roundup(theValue)
  warning("roundup is dprecated. Use ceil.");
  result = round(theValue+0.5);
endfunction