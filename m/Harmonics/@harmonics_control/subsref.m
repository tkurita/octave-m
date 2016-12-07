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
        case "phis_vs_t"
          retval = [x._properties.phis, x._properties.t_in_ms];
        case "phase_ctrlv_amp"
          retval = max(x._properties.phase_ctrlv) - min(x._properties.phase_ctrlv);
        otherwise
          retval = x._properties.(fld);
      endswitch
    otherwise
      error("invalid subscript type");
  endswitch
  if (numel(s) > 1)
    retval = subsref(retval, s(2:end));
  endif
endfunction
