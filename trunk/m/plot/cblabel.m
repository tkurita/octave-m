##
## -*- texinfo -*-
## @deftypefn {Function File} {} cblabel (@var{string})
## See xlabel.
## @end deftypefn

## Author: tkurita

function h = cblabel (varargin)

  ## XXX FIXME XXX -- eventually, we will return a graphics handle.  For
  ## now, return something, so that calls that expect a handle won't
  ## fail (at least immediately).

  if (nargout > 0)
    h = __axis_label__ ("cblabel", varargin{:});
  else
    __axis_label__ ("cblabel", varargin{:});
  endif

endfunction
