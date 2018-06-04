## -*- texinfo -*-
## @deftypefn {Function File} {@var{h} =} arc(@var{center}, @var{radius}, @var{beginning_angle}, @var{end_anble})
##
## Draw an arc.
##
## @strong{Inputs}
## @table @var
## @item center
## a point of a center of arc. [x, y].
## @item beginning_angle
## beginning angle in degree.
## @item end_angle
## end angle in degree.
## @end table
##
## @strong{Outputs}
## @table @var
## @item h
## handle of the arc.
## @end table
##
## @end deftypefn

function h = arc(varargin)
  if nargin < 4
    print_usage();
    return;
  end

  [reg, prop] = parseparams(varargin);
  c = reg{1};
  r = reg{2};
  beg_angle = reg{3};
, end_angle = reg{4};
  q = linspace(beg_angle*pi/180, end_angle*pi/180, 500);
  x = r*cos(q) + c(1);
  y = r*sin(q) + c(2);
  h = line(x, y, prop{:});
endfunction

%!test
%! func_name(x)
