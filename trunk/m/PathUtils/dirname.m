## -*- texinfo -*-
## @deftypefn {Function File} {@var{result} =} dirname(@var{fpath})
##
## @end deftypefn

##== History
## 2008-08-13
## * first implementation

function retval = dirname(fpath)
   # fpath = "/aaa/bbb/"
   pelems = regsplit(fpath, "/");
   if (isempty(pelems{end}))
     pelems = pelems(1:end-1);
   endif

   if (length(pelems) > 1)
     pelems = pelems(1:end-1);
   endif
   retval = joincell2string(pelems, "/");
endfunction

%!test
%! dirname(x)
