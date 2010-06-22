## -*- texinfo -*-
## @deftypefn {Function File} {@var{result} =} print_pdf(@var{fname})
##
## Output plot as PDF file of which font size is 10 and size is 8,5.
##
## @end deftypefn

##== History
##

function retval = print_pdf(fname)
  #xy = [11, 8.5];
  xy = [8, 5];
  orient("landscape");
  set(gcf, "papersize", xy);
  set(gcf, "paperposition", [0,0,xy(1),xy(2)]);
  #set(gcf, "paperposition", [0,0,8,5]);
  #print("-S8,5","-F:10","-dpdf", fname);
  print("-F:10", "-dpdf", fname); # -F は legend だけに効く
  #print("-dpdf", fname); 
  #print("-S12,10","-F:14","-dpdf", fname);
endfunction

%!test
%! print_pdf(x)
