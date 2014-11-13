## -*- texinfo -*-
## @deftypefn {Function File} {@var{retval} =} subsref(@var{arg})
## 
## isfdata.v returns values in units of volt.
##
## isfdata.preambles returns preambles of isf file as a dict object.
##
## isfdata.preambles("name") returns a value of "name" entry in the preambles.
##
## @end deftypefn

##== History
## 2014-11-13
## * added .t
## * added .ts (sampling interval)
## 2012-10-16
## * initial implementation

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
        case "ts" # sampling interval
          retval = str2num(find_dict(x.preambles, {"XIN", "XINCR"}));
        case "t"
            xinc = str2num(find_dict(x.preambles, {"XIN", "XINCR"}));
            n = 0:length(x.v)-1;
            xzero = str2num(find_dict(x.preambles, {"XZE", "XZERO"}));
            retval = n*xinc + xzero;
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
