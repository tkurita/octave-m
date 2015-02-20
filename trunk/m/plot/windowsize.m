## -*- texinfo -*-
## @deftypefn {Function File} {@var{figsize} =} windowsize(@var{width}, @var{height})
## Deprecated. Use figure size.
## 
## @end deftypefn

##== History
## 2015-02-20
## * renamed to figuresize.
## 2014-11-13
## * first implementaion

function retval = windowsize(varargin)
  warning("windowsize is deprecated. Use figuresize");
  retval = figuresize(varargin{:});
endfunction
