## -*- texinfo -*-
## @deftypefn {Function File} {@var{template} =} ftemplate_for_mat(@var{a}, [@var{props}])
## 
## Generate template for printf row vectors of matrix @var{a}.
## 
## @table @code
## @item preciction
## The default value is "%.16g"
## @item delim
## The default is ","
## @item newline
## The default is "\n"
## @end table
##
## @example
## a = [1,2;3,4];
## template = ftemplate_for_mat(a)
## for n = 1:rows(a)
##   printf(template, a(n, :));
## endfor
## @end example
## @end deftypefn

##== History
## 2008-12-03
## * First implementation

function template = ftemplate_for_mat(a, varargin)
  opts = get_properties(varargin, {"precision", "delim", "newline"}, {"%.16g", ",", "\n"});
  if (iscomplex (a))
    cprecision = regexprep (opts.precision, '^%([-\d.])', '%+$1');
    template = [opts.precision, cprecision, "i", ...
                repmat([opts.delim, opts.precision, cprecision, "i"], 1, columns(a)-1), ...
                opts.newline];
  else
    template = [opts.precision, repmat([opts.delim, opts.precision], 1, columns(a)-1), opts.newline];
  endif
endfunction


%!test
%! ftemplate_for_mat(x)
