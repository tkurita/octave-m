## -*- texinfo -*-
## @deftypefn {Function File} {@var{retval} =} subsref(@var{arg})
## 
## @table @code
## @item .v
## returns values in units of volt.
## @item .t
## returns time series
## @item .ts
## returns sampling interval
## @item .preambles
## returns preambles of isf file as a dict object.
## @item .preambles("name")
## returns a value of "name" entry in the preambles.
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
        case "ts" # sampling interval
          retval = str2num(find_field(x.preambles, {"XIN", "XINCR"}));
        case "t"
            xinc = str2num(find_field(x.preambles, {"XIN", "XINCR"}));
            n = 0:length(x.v)-1;
            xzero = str2num(find_field(x.preambles, {"XZE", "XZERO"}));
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
