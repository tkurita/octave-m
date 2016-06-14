## -*- texinfo -*-
## @deftypefn {Function File} {@var{retval} =} func_name(@var{h}, @var{wo})
## normalize magnitude of @var{h} at \var{wo}
## @strong{Inputs}
## @table @var
## @item h
## filter
## @item wo
## magnitude response at @var{wo} is normalized to 1.
## if @var{h} is LPF, @var{wo} shdould be 0.
## @end table
##
## @strong{Outputs}
## @table @var
## @item retval
## normalized @var{h}
## @end table
##
## @end deftypefn

##== History
## 2014-11-12
## * first implementation

function retval = normalize_filter(h, wo)
  if nargin < 2
    print_usage();
  endif

  ## compute |h(wo)|^-1
  renorm = 1/abs(polyval(h, exp(-1i*pi*wo)));

  ## normalize the filter
  retval = renorm*h;
endfunction

%!test
%! func_name(x)
