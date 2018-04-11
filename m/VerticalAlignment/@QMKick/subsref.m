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
