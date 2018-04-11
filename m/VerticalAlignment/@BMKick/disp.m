function disp(x)
  if ! nargin
    print_usage();
    return;
  endif
  
  printf("%4s %11s %11s %11s %11s %11s\n" ...
        , "name", "skew_total", "tilt", "pitch", "inedge", "outedge");
  for n = 1:length(x.names)
    printf("%4s %11.4e %11.4e %11.4e %11.4e %11.4e\n", x.names{n}, x.dyds.skew_total(n), x.dyds.tilt(n), x.dyds.pitch(n), x.dyds.inedge(n), x.dyds.outedge(n));
  end
endfunction

%!test
%! func_name(x)
