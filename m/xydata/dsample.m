## -*- texinfo -*-
## @deftypefn {Function File} {@var{retval} =} dsample(@var{mat}, @var{N})
## down sample rows of @var{mat} until about @var{N}.
## @strong{Inputs}
## @table @var
## @item mat
## A row-wise matrix
## @item N
## Expected number of rows.
## @end table
##
## @strong{Outputs}
## @table @var
## @item retval
## A matrix whose rows are down sampled.
## @end table
##
## @end deftypefn

##== History
## 2013-11-12
## * first implementation

function retval = dsample(mat, N)
  if ! nargin
    print_usage();
  endif

  n_rows = rows(mat);
  if n_rows <= N
    retval = mat;
    return;
  endif
  
  n_skip = round(n_rows/N);
  if n_skip < 2
    n_skip = 2;
  endif
  ir = 1:n_skip:n_rows;
  retval = mat(ir, :);
endfunction

%!test
%! func_name(x)
