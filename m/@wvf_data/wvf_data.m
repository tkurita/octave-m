## -*- texinfo -*-
## @deftypefn {Function File} {@var{retval} =} wvf_data(@var{filename})
## load .wvf file saeved by a Yokogawa DL osciroscope.
##
## @example
## wvf = wvf_data("path/to/file"); # a path stripping a path extension
## wvf{1} # obtain t-y data of the trace 1
## wvf.info # obtain infomation
## @end example
##
## @strong{Outputs}
## @table @var
## @item retval
## wvf_data object
## @end table
##
## @end deftypefn

##== History
## 2015-02-03
## * first implementation

function retval = wvf_data(filename)
  if ! nargin
    print_usage();
  endif
  [y, info] = wvfreadall(filename);
  retval.info = info;
  retval.data = y;
  retval = class(retval, "wvf_data");
endfunction

%!test
%! func_name(x)
