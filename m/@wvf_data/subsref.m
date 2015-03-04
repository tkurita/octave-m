## -*- texinfo -*-
## @deftypefn {Function File} {@var{retval} =} subsref(@var{arg})
## 
## @example
## wvf{1} # obtain t-y data of the trace 1
## wvf.info # obtain infomation
## @end example
####
## @end deftypefn

##== History
## 2015-02-03
## * first implementation

function retval = subsref(x, s)
  if (isempty(s))
    error("missing index");
  endif
  switch s(1).type
    case "()"
    case "{}"
      idxes = s.subs;
      if length(idxes) < 2
        gidx = 1;
        tidx = idxes{1};
      else
        gidx = idxes{1};
        tidx = idexes{2};
      endif
      grpname = ["Group", num2str(gidx)];
      trcname = ["Trace", num2str(tidx)];
      trc = x.data.(grpname).(trcname);
      t = trc.t;
      trp = x.info.TriggerPointNo;
      hreso = x.info.(grpname).(trcname).HResolution;
      t = t - trp*hreso;
      retval = [t(:), trc.Block1(:)];
    case "."
      fld = s.subs;
      retval = x.(fld);
    otherwise
      error("invalid subscript type");
  endswitch
  if (numel(s) > 1)
    retval = subsref(retval, s(2:end));
  endif
endfunction

function retval = find_field(s, keys)
  for k = keys
    if isfield(s, k{:})
      retval = s.(k{:});
      return;
    endif
  endfor
endfunction

function retval = find_dict(a_dict, keys)
  for k = keys
    if has(a_dict, k{:})
      retval = a_dict(k{:});
      return
    endif
  endfor
endfunction


%!test
%! func_name(x)
