## -*- texinfo -*-
## @deftypefn {Function File} {@var{retval} =} xypeaks(@var{xy}, ["offset", @var{offset}, "xrange", @var{xrange}, "MinPeakHeight", @var{hight}, "MinPeakDistance", @var{distance} ,"plot")
## Find peaks in xy data using findpeaks of the signal package.
## A matrix of xy of peaks is returned.
##
## @end deftypefn

function retval = xypeaks(xy, varargin)
  if ! nargin
    print_usage();
  endif
  
  p = inputParser();
  p.FunctionName = "xypeaks";
  p = addParamValue(p, "offset", 0);
  p = addParamValue(p, "MinPeakHeight", []);
  p = addParamValue(p, "MinPeakDistance", []);
  p = addParamValue(p, "xrange", []);
  p = addSwitch(p, "plot");
  
  p = parse(p, varargin{:});
  
  offset = p.Results.offset;
  
  opts = {};
  if !isempty(p.Results.MinPeakHeight)
    opts{end+1} = "MinPeakHeight";
    opts{end+1} = p.Results.MinPeakHeight;
  endif
  
  if !isempty(p.Results.MinPeakDistance)
    opts{end+1} = "MinPeakDistance";
    opts{end+1} = p.Results.MinPeakDistance;
  endif
  
  if !isempty(p.Results.xrange)
    xy = xy_in_xrange(xy, p.Results.xrange);
  endif
  y = xy(:,2) + offset;

  pkg load signal;
  [pks, idx] = findpeaks(y, opts{:});
  retval = xy(idx, :);

  if p.Results.plot
    xyplot(xy, "-", retval, "*");
  endif
endfunction

%!test
%! func_name(x)
