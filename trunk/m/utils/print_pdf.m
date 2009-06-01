## -*- texinfo -*-
## @deftypefn {Function File} {@var{result} =} print_pdf(@var{fname})
##
## Output plot as PDF file of which font size is 10 and size is 8,5.
## @end deftypefn

##== History
##

function retval = print_pdf(fname)
  print("-S8,5","-F:10","-dpdf", fname);
endfunction

%!test
%! print_pdf(x)
