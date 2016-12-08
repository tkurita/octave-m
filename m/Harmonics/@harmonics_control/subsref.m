## -*- texinfo -*-
## @deftypefn {Function File} {@var{retval} =} subsref(@var{arg})
##
## @end deftypefn

function retval = subsref(self, s)
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
          retval = [self._properties.phis, self._properties.t_in_ms];
        case "phase_ctrlv_amp"
          retval = max(self._properties.phase_ctrlv) - min(self._properties.phase_ctrlv);
        case "phis_for_frev"
          f = s(2).subs{1};
          retval = interp1(self._properties.rf_in_Hz, self._properties.phis, f);
          if (numel(s) > 2)
            s = s(2:end);
          else
            return;
          endif
        otherwise
          retval = self._properties.(fld);
      endswitch
    otherwise
      error("invalid subscript type");
  endswitch
  if (numel(s) > 1)
    retval = subsref(retval, s(2:end));
  endif
endfunction
