## -*- texinfo -*-
## @deftypefn {Function File} {@var{retval} =} subsref(@var{arg})
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
        case "rad_v"
          retval = [x.v, x.rad];
        otherwise
          retval = x.(fld);
      endswitch
    otherwise
      error("invalid subscript type");
  endswitch
  if (numel(s) > 1)
    retval = subsref(retval, s(2:end));
  endif
endfunction
