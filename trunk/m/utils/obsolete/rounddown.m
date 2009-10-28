## floor を使う
## usage: result = rounddown(theValue)
## 
## result : rounddowned number From theValue

function result = rounddown(theValue)
  warning("rounddown is deprecated. Use floor.");
  result = round(theValue-0.5);
endfunction