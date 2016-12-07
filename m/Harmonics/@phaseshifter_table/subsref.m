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
      fld = s(1).subs;
      switch fld
        case "curve_for_Hz"
          retval = curve_for_freq(x, s(2).subs{1} * 1e-6);
          if (numel(s) > 2)
            s = s(2:end);
          else
            return;
          endif
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

