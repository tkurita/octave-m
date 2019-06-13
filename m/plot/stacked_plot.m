## -*- texinfo -*-
## @deftypefn {Function File} {@var{hax} =} stacked_plot(@var{rows}, @var{index})
## @deftypefnx {Function File} {@var{hax} =} stacked_plot(@var{rows}, @var{cols}, @var{index})
## @deftypefnx {Function File} {} stacked_plot("margin", @var{margin})
## @deftypefnx {Function File} {} stacked_plot("spacing", @var{spacing})
## Set up a plot grid removing vertical and horizontal spaces between subwindows.
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
## If some figures vanish, fine adjust margins or spacing
## 
## @strong{Example}
## @example
## stacked_plot("margin", [0.11, 0.12, 0.05, 0.1]); #opional
## stacked_plot("spacing", 0.1); #optional
## # vertical stack
## stacked_plot(2,1);
## plot(x1);
## stacked_plot(2,2);
## plot(x2);
##
## # matrix stack
## stacked_plot(2,2,1);
## plot(x1);
## stacked_plot(2,2,2);
## plot(x2); 
## stacked_plot(2,2,3);
## plot(x3); 
## stacked_plot(2,2,4);
## plot(x4); 
## @end example
## 
## @seealso{subplot}
## @end deftypefn

function retval = stacked_plot(varargin)
  if ! nargin
    print_usage();
  endif
  persistent dm = [0.11, 0.12, 0.05, 0.1]; # optimized for fltk and fontsize 10
  persistent lm = dm(1); # left margin
  persistent bm = dm(2); # bottom margin
  persistent rm = dm(3); # right margin
  persistent tm = dm(4); # top margin
  persistent defspacing = 0;
  persistent spacing = 1e-6;
  if ischar(varargin{1})
    n = 1;
    while n <= length(varargin)
      switch varargin{n} 
        case "margin"
          if (length(varargin) == 1)
            retval = [lm, bm, rm, tm];
            return
          endif
          margin = varargin{++n};
          if ischar(margin)
            switch margin
              case "default"
                margin = dm;
                retval = margin;
              otherwise
                disp margin;
                error("Unknown option for the margin parameter.");
            endswitch
            return
          endif
          lm = margin(1);
          bm = margin(2);
          rm = margin(3);
          tm = margin(4);
        case "spacing"
          if (length(varargin) == 1)
            retval = spacing;
            return;
          endif
          sp = varargin{++n};
          if ischar(sp)
            switch sp
              case "default"
                spacing = defspacing;
                retval = spacing;
              otherwise
                disp sp;
                error("Unknown option for the spacing parameter.");
            endswitch
            return
          endif
          spacing = sp;
        otherwise
          disp varargin{n};
          error("Unknown parameter label.");
        endswitch
        n++;
      endwhile
    return;
  endif
  
  switch length(varargin)
    case 2
      nrows = varargin{1};
      pltindex = varargin{2};
      ncols = 1;
    case 3
      nrows = varargin{1};
      ncols = varargin{2};
      pltindex = varargin{3};
    otherwise
      error("Invalid number of arguments.");
  endswitch

  fw = 1 - lm - (rm-spacing); # figure width
  aw = fw/ncols; # axes width
  fh = 1 - bm - (tm -spacing); # figure height
  ah = fh/nrows; # axes hight
  rowidx = ceil(pltindex/ncols);
  colidx = pltindex - (rowidx-1)*ncols;
  retval = subplot("position", [lm+aw*(colidx-1), bm+ah*(nrows-rowidx), aw-spacing, ah-spacing]);
endfunction

%!test
%! func_name(x)
