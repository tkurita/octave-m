## -*- texinfo -*-
## @deftypefn {Function File} {} set (@var{dat})
## @deftypefnx {Function File} {} set (@var{dat}, @var{"property"}, @var{value}, @dots{})
## @deftypefnx {Function File} {@var{dat} =} set (@var{dat}, @var{"property"}, @var{value}, @dots{})
## Set or modify properties of iddata objects.
## If no return argument @var{dat} is specified, the modified @acronym{LTI} object is stored
## in input argument @var{dat}.  @command{set} can handle multiple properties in one call:
## @code{set (dat, 'prop1', val1, 'prop2', val2, 'prop3', val3)}.
## @code{set (dat)} prints a list of the object's property names.
## @end deftypefn

function retx = set (x, varargin)

  if (nargin == 1)       # set (dat), dat = set (dat)
    # not implemented
#    [props, vals] = __property_names__ (dat);
#    nrows = numel (props);
#
#    str = strjust (strvcat (props), "right");
#    str = horzcat (repmat ("   ", nrows, 1), str, repmat (":  ", nrows, 1), strvcat (vals));
#
#    disp (str);
#
#    if (nargout != 0)       # function dat = set (dat, varargin)
#      retdat = dat;         # would lead to unwanted output when using
#    endif                   # set (dat)
  else      # set (dat, "prop1", val1, ...), dat = set (dat, "prop1", val1, ...)

    if (rem (nargin-1, 2))
      error ("fourier: set: properties and values must come in pairs");
    endif
    [n, p, m, e] = size (x);

    for k = 1 : 2 : (nargin-1)
      prop = lower (varargin{k});
      val = varargin{k+1};
      x.(prop) = val;
    endfor

    if (nargout == 0)    # set (dat, "prop1", val1, ...)
      assignin ("caller", inputname (1), x);
    else                 # dat = set (dat, "prop1", val1, ...)
      retx = x;
    endif

  endif

endfunction