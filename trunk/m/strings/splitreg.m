## usage: outList = splitreg(inStr, pattern)

function outList = splitreg(inStr, pattern)
#  pattern = "[ 	]+";
#  inStr = "hello   	123  456 hello  ";
  outList = {};
  match = regexp(pattern, inStr);
  while (length(match) > 0)  
	if (match(1) > 1)
	   s = inStr(1:(match(1)-1));
	   outList = {outList{:},s};
	 endif
	 inStr = inStr(match(2)+1:end);
     match = regexp(pattern, inStr);
   endwhile
   
   if (length(inStr) > 1)
	 outList = {outList{:},inStr};
   endif
   #outList
endfunction