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

function retval = subsref(x, s)
  if (isempty(s))
    error("missing index");
  endif
  switch s(1).type
    case "()"
    case "{}"
    case "."
      fld = s.subs;
      switch fld
        case "mean"
          retval = mean(mean(x.data, 2));
        otherwise
          retval = x.(fld);
      end
    otherwise
      error("invalid subscript type");
  endswitch

  if (numel(s) > 1)
    retval = subsref(retval, s(2:end));
  endif
endfunction

%!test
%! func_name(x)
