## -*- texinfo -*-
## @deftypefn {Function File} {@var{retval} =} setup_positions(@var{all_elements})
## setup "entrancePosition", "centerPosition" and "exitPosition" into each elements of @var{all_elements}.
## Use this function to know positions of elements without calculating lattice.
## @strong{Inputs}
## @table @var
## @item all_elements
## a cell array of elements of a ring.
## @end table
##
## @strong{Outputs}
## @table @var
## @item retval
## a cell array including "entrancePosition", "centerPosition" and "exitPosition".
## @end table
##
## @end deftypefn

##== History
## 2013-10-29
## * first implementation

function retval = setup_positions(all_elements)
  if ! nargin
    print_usage()
  endif

  a_pos = 0;
  retval = {};
  if iscolumn(all_elements)
    all_elements = all_elements';
  endif

  for elem = all_elements
    elem = elem{1};
    elem.entrancePosition = a_pos;
    a_pos += elem.len;
    elem.exitPosition = a_pos;
    elem.centerPosition = (elem.entrancePosition + elem.exitPosition)/2;
    retval{end+1} = elem;
  endfor
endfunction

%!test
%! func_name(x)
