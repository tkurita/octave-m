function disp(x)
  if ! nargin
    print_usage();
    return;
  endif
  
  printf("%4s %11s\n" ...
        , "name", "kick");
  for n = 1:length(x.names)
    printf("%4s %11.4e \n", x.names{n}, x.dyds(n));
  end
endfunction

%!test
%! func_name(x)
