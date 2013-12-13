## -*- texinfo -*-
## @deftypefn {Function File} {@var{bool} =} isfield(@var{x}, @var{name})
## Return true if @var{x} has a mamber named @var{name}.
##
## @end deftypefn

##== History
## 2013-11-27
## * first implementation

function retval = isfield(s, name)
  retval = any(strcmp(fieldnames(s), name));
endfunction

%!test
%! func_name(x)
