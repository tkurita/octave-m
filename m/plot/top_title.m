## -*- texinfo -*-
## @deftypefn {Function File} {@var{h} =} top_title(@var{title_text})
## Set a title in the first subplot.
##
## @strong{Outputs}
## @table @var
## @item h
## graphics handle of the created text object.
## @end table
##
## @end deftypefn

function retval = top_title(title_text)
  if ! nargin
    print_usage();
  endif
  h = title(find_axes()(end), title_text);
endfunction

%!test
%! func_name(x)
