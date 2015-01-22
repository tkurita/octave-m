## -*- texinfo -*-
## @deftypefn {Function File} {@var{hax} =} stacked_plot(@var{rows}, @var{index})
## @deftypefnx {Function File} {} stacked_plot("margin", @var{margin})
## Set up a plot grid removing vertical spaces between subwindows.
## @strong{Inputs}
## @table @var
## @item rows
## number of rows.
## @item index
## first plot is placed at the top.
## @item margin
## 4 elements vector of [left, bottom, right, top]
## @end table
##
## @end deftypefn

##== History
## 2015-01-22
## * first implemantaion

function retval = stacked_plot(varargin)
  if ! nargin
    print_usage();
  endif
  persistent dm = [0.11, 0.12, 0.05, 0.1]; # optimized for fltk and fontsize 10
  persistent lm = dm(1); # left margin
  persistent bm = dm(2); # bottom margin
  persistent rm = dm(3); # right margin
  persistent tm = dm(4); # top margin
  if ischar(varargin{1}) && strcmp(varargin{1}, "margin")
    if (length(varargin) == 1)
      retval = [lm, bm, rm, tm];
      return;
    endif
    margin = varargin{2};
    if ischar(margin) && strcmp(margin, "default")
      margin = dm;
    endif
    lm = margin(1);
    bm = margin(2);
    rm = margin(3);
    tm = margin(4);
    return;
  endif
  nrows = varargin{1};
  pltindex = varargin{2};
  aw = 1 - lm - rm;
  fh = 1 - bm - tm; # figure height
  ah = fh/nrows
  retval = subplot("position", [lm, bm+ah*(nrows-pltindex), aw, ah]);
endfunction

%!test
%! func_name(x)
