## -*- texinfo -*-
## @deftypefn {Function File} {@var{retval} =} func_name(@var{arg})
## description
## @strong{Inputs}
## @table @var
## @item arg1
## description of @var{arg}
## @end table
##
## @strong{Outputs}
## @table @var
## @item retval
## description of @var{retval}
## @end table
##
## @end deftypefn

##== History
##

function x = set (x, varargin)

 if (length (varargin) < 2 || rem (length (varargin), 2) != 0)
   error ("set: expecting property/value pairs");
 endif
 
 while (length (varargin) > 1)
   prop = varargin{1};
   val = varargin{2};
   varargin(1:2) = [];
   x.(prop) = val; 
   #error ("set: invalid property of cod class");
 endwhile
endfunction


%!test
%! func_name(x)
