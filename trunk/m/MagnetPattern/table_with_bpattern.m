## -*- texinfo -*-
## @deftypefn {Function File} {@var{result} =} table_with_bpattern(@var{bpattern}, @var{opts})
## 
## Print @var{bpattern} with simple table format.
## 
## If returned value is given, a matrix is returned instead of print to a screen.
##
## @seealso{build_pattern, csv_with_bpattern}
##
## @end deftypefn

##== History
## 2009-06-11
## * If "file" is ommited, output is stdout.
##
## 2008-12-04
## * First implementation

function varargout = table_with_bpattern(bpattern, varargin)
  if !nargin
    print_usage();
  endif
  opts = get_properties(varargin, {"output", "format"},
                        {stdout, "%.1f\t%.4f\n"});
  t = bpattern{1}.tPoints(:);
  b = bpattern{1}.bPoints(:);
  for n = 2:length(bpattern)
    t =[t; bpattern{n}.tPoints(2:end)(:)];
    b =[b; bpattern{n}.bPoints(2:end)(:)];
  endfor
  tb = [t, b];
  
  is_open_file = false;
  if (ischar(opts.output))
    [fid , msg] = fopen(opts.output, "w");
    if (fid < 0)
      error(msg);
    endif
    is_open_file = true;
  elseif (isfid(opts.output))
    fid = opts.output;
  else
    error("File specification is invalid.");
  endif
  
  
  if (nargout > 0)
    varargout = {tb};
  else
    fprintf(fid, opts.format, tb');
    if (is_open_file)
      fclose(fid);
    endif
  endif
endfunction

%!test
%! table_with_bpattern(x)
