## -*- texinfo -*-
## @deftypefn {Function File} {@var{result} =} load_named_data(@var{filename})
##
## first row : names of kind of data
## first col : names of data set
## 
## result.(dataset_name) = {name_of_kind, values}
##
## @end deftypefn

##== History
## 2014-11-11
## * added "pkg load io".
## * use applyfun instead of map.
## 2010-03-25
## * First implementaion

function data_sets = load_named_data(filename)
  # filename = "vac_data_test.csv";
  [fid, msg] = fopen(filename, "r");
  if (fid == -1)
    error(msg);
  endif
  
  pkg load io;  
  aline = read_line(fid);
  data_names = csvexplode(aline)(2:end);
  data_sets = struct;
  n_names = length(data_names);
  while (1)
    aline = read_line(fid);
    if (aline == -1) break; endif
    rowdata = csvexplode(aline);
    set_name = rowdata{1};
    vals = rowdata(2:end);
    num_vals = arrayfun(@eval_chars, vals, "Uniformout", false);
    n_vals = length(num_vals);
    if (n_names < n_vals) n_vals = n_names; end;
    data_sets.(set_name) = [data_names(1:n_vals)(:), num_vals(1:n_vals)(:)];
  endwhile
  fclose(fid);
endfunction

function result = eval_chars(x)
  x = x{1};
  if ischar(x)
    if length(x)
      try
        result = eval(x);
      catch
        result = NaN;
      end_try_catch
    else
      result = NaN;
    endif
  else
    result = x;
  endif
endfunction

function result = read_line(fid)
  aline = fgetl(fid);
  if (aline == -1)
    result = aline;
    return;
  endif
  s = regexp(aline, "^\\s*#");
  if length(s);
    result = read_line(fid);
  else
    s = regexp(aline, "^\\s*$");
    if length(s)
      result = read_line(fid);
    else
      result = aline;
    endif
  endif
endfunction

%!test
%! func_name(x)
