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
        case "allnames"
          retval = reshape([x.inedgenames, x.names, x.outedgenames]' ...
                           , length(x.names)*3, 1); 
        case "edgenames"
          retval = reshape([x.inedgenames, x.outedgenames]' ...
                           , length(x.inedgenames)*2, 1);
        case "edgekicks"
          retval = reshape([x.dyds.inedge, x.dyds.outedge]' ...
                          , length(x.inedge)*2, 1);
        case "allkicks"
          retval = reshape([x.dyds.inedge, x.dyds.skew_total, x.dyds.outedge]' ...
                      , length(x.names)*3, 1);
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
