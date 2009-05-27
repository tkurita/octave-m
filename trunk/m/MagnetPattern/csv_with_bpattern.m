## -*- texinfo -*-
## @deftypefn {Function File} {} csv_with_bpattern(@var{bpattern}, @var{file})
##
## @seealso{build_pattern, table_with_bpattern}
## @end deftypefn

##== History
## 2008-12-03
## * First implementaion

function csv_with_bpattern(bpattern, file)
  # bpattern = retval
  # file = "testout"
  is_open_file = false;
  if (exist("file", "var"))
    if (ischar(file))
      [fid , msg] = fopen(file, "w");
      if (fid < 0)
        error(msg);
      endif
      is_open_file = true;
    elseif (isfid(file))
      fid = file;
    else
      error("File specification is invalid.");
    endif
  else
    fid = stdout;
  endif
  
  for n = 1:length(bpattern)
    #n = 3
    switch bpattern{n}.funcType
      case "linear"
        b = bpattern{n}.bPoints;
        if (b(1) == b(2))
          ltype = 1;
        else
          ltype = 2;
        endif
        
      case "spline"
        ltype = 5;
      otherwise
        error("Unknown funcType.");
    endswitch
    tb = [bpattern{n}.tPoints(:), bpattern{n}.bPoints(:)];
    tb = [ltype, reshape(tb', 1, rows(tb)*2)];
    template = template_for_mat(tb);
    fprintf(fid, template, tb);
    #c = mat2cell(tb, ones(1, rows(tb)), ones(1, columns(tb)));
    #csvwrite(FILE, tb);
    #csvwrite(FILE, tb);
  endfor
  if (is_open_file)
    fclose(fid);
  endif
endfunction

function template = template_for_mat(a)
  precision = "%.4f";
  newline = "\n";
  delim = ",";
  if (iscomplex (a))
    cprecision = regexprep(precision, '^%([-\d.])','%+$1');
    template = [precision, cprecision, "i", ...
    repmat([delim, precision, cprecision, "i"], 1, ...
    columns(a) - 1), newline ];
  else
    template = [precision, repmat([delim, precision], 1, columns(a)-1),...
    newline];
  endif
endfunction

%!test
%! csv_with_bpattern(x)
