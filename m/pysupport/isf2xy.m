## -- retval = isf2xy(filename)
##     isf ファイルを読み込んで python 用 xy データを返す
##
##  * Outputs *
##    x: retval(1)
##    y: retval(2)
##    
##
##  See also: 

function retval = isf2xy(filename)
  if ! nargin
    print_usage();
    return;
  endif
  retval = xy(isf_data(filename))';
endfunction

%!test
%! func_name(x)
