## -*- texinfo -*-
## @deftypefn {Function File} frev_with_brho(@var{brho}, @var{circumference}, @var{particle})
##
## Calculate revolution frequency [Hz] of a particle from its Brho value.
## It is assumed that the harmonics is 1.
##
## @table @code
## @item @var{brho}
## B*rho [T*m]
## @item @var{circumference}
## circumference of the ring [m]
## @item @var{particle}
## kind of a particle, should be "proton" or "carbon" or mass number.
## @item @var{charge}
## charge number.
## @end table
##
## @end deftypefn

##== History
## 2013-08-16
## * charge parameter is optional.
## 2012-08-30
## * Initial implemented

function result = frev_with_brho(brho, circumference, varargin)
  if (!nargin)
    print_usage();
    return;
  endif
  v = velocity_with_brho(brho, varargin{:});
  result = v/circumference;
endfunction

%!test
%! frev_with_brho(0.38694, 33.201, "proton", 1)