## -*- texinfo -*-
## Subscripted assignment for fourier objects.
## Used by Octave for "dat.property = value".


##== History
## 2015-02-24
## * first implementation

function x = subsasgn(x, idx, val)
  switch idx(1).type
    case "."                            # x.y... = val
      if (length (idx) == 1)            # x.y = val
        x.(idx.subs) = val;
#        if isfield(x, idx.subs)
#          x.(idx.subs) = val;
#        else
#          x._aux.(idx.subs) = val;
#        endif
#      else                   # x.y(...) = val, x.expname{3} = val
#        key = idx(1).subs;
#        
#        x = set (x, key, subsasgn (get (dat, key), idx(2:end), val));
      endif
    otherwise
     error ("fourier: subsasgn: invalid subscripted assignment type");
  endswitch
endfunction

%!test
%! func_name(x)
