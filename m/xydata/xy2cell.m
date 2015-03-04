## -*- texinfo -*-
## @deftypefn {Function File} {@var{retval} =} xy2cell(@var{xy})
## return {xy(:,1), xy(:,2)}.
## Use pass xy data to plot command as follows:
## plot(xy2cell(xy){:})
##
## @end deftypefn

##== History
## 2014-07-09
## * first implementation

function retval = xy2cell(xy)
  if ! nargin
    print_usage();
  endif
  
  retval = {xy(:,1), xy(:,2)};
endfunction
