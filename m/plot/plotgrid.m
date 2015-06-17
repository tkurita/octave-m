## -*- texinfo -*-
## @deftypefn {Function File} {@var{hax} =} plotgrid(@var{ridx},@var{cidx})
## @deftypefn {Function File} {} plotgrid("layout", [@var{rows},@var{columns}])
## @deftypefnx {Function File} {} plotgrid("margin", @var{margin})
## @deftypefnx {Function File} {} plotgrid("horizontal spacing", @var{hs})
## @deftypefnx {Function File} {} plotgrid("vertical spacing", @var{vs})
## @deftypefnx {Function File} {} plotgrid("title", @var{tt})
## Set up a plot grid adjusting vertical and horizontal spaces between subwindows and margins.
## @strong{Inputs}
## @table @var
## @item ridx
## index of row to place a plot.
## @item cidx
# index of column to place a plot.
## @item rows
## number of rows.
## @item columns
## number of columns.
## @item margin
## 4 elements vector of [left, bottom, right, top]
## @end table
##
## @strong{Example}
## @example
## plotgrid("layout", [2,2], "horizontal spacing", 0.05);
## plotgrid(1,1);plot(data);
## plotgrid(1,2);plot(data);
## plotgrid(2,1);plot(data);
## plotgrid(2,2);plot(data);
## plotgrid("title", "title text");
## @end example
##
## If some figures vanish, fine adjust margins or spacing.
##
## @seealso{subplot}
## @end deftypefn

function retval = plotgrid(varargin)
  if ! nargin
    print_usage();
  endif
  persistent dm = [0.11, 0.12, 0.05, 0.1]; # optimized for fltk and fontsize 10
  persistent lm = dm(1); # left margin
  persistent bm = dm(2); # bottom margin
  persistent rm = dm(3); # right margin
  persistent tm = dm(4); # top margin
  persistent defvspacing = 0;
  persistent defhspacing = 0;
  persistent vspacing = 0; # vertical spacing
  persistent hspacing = 0; # horizontal spacing
  persistent nrows = 2;
  persistent ncolumns = 2;
  
  if ischar(varargin{1})
    n = 1;
    while n <= length(varargin)
      switch varargin{n}
        case "layout"
          if (length(varargin) == 1)
            retval = [nrows, ncolumns];
            return
          endif
          layout = varargin{++n};
          nrows = layout(1);
          ncolumns = layout(2);
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
        case "top margin"
          if (length(varargin) == 1)
            retval = tm;
            return
          endif
          m = varargin{++n};
          if ischar(m)
            switch m
              case "default"
                tm = dm(4);
                retval = tm;
              otherwise
                disp m;
                error("Unknown option for the top margin parameter.");
            endswitch
            return
          endif
          tm = m;
        case "bottom margin"
          if (length(varargin) == 1)
            retval = bm;
            return
          endif
          m = varargin{++n};
          if ischar(m)
            switch m
              case "default"
                bm = dm(3);
                retval = bm;
              otherwise
                disp m;
                error("Unknown option for the bottom margin parameter.");
            endswitch
            return
          endif
          bm = m;
        case "left margin"
          if (length(varargin) == 1)
            retval = lm;
            return
          endif
          m = varargin{++n};
          if ischar(m)
            switch m
              case "default"
                lm = dm(1);
                retval = lm;
              otherwise
                disp m;
                error("Unknown option for the left margin parameter.");
            endswitch
            return
          endif
          lm = m;
        case "right margin"
          if (length(varargin) == 1)
            retval = rm;
            return
          endif
          m = varargin{++n};
          if ischar(m)
            switch m
              case "default"
                rm = dm(2);
                retval = rm;
              otherwise
                disp m;
                error("Unknown option for the right margin parameter.");
            endswitch
            return
          endif
          rm = m;
        case "vertical spacing"
          if (length(varargin) == 1)
            retval = vspacing;
            return;
          endif
          sp = varargin{++n};
          if ischar(sp)
            switch sp
              case "default"
                vspacing = defvspacing;
                retval = vspacing;
              otherwise
                disp sp;
                error("Unknown option for the spacing parameter.");
            endswitch
            return
          endif
          vspacing = sp;
        case "horizontal spacing"
          if (length(varargin) == 1)
            retval = hspacing;
            return;
          endif
          sp = varargin{++n};
          if ischar(sp)
            switch sp
              case "default"
                hspacing = defhspacing;
                retval = hspacing;
              otherwise
                disp sp;
                error("Unknown option for the spacing parameter.");
            endswitch
            return
          endif
          hspacing = sp;
        case "title"
          title_text = varargin{++n};
          ax = subplot("position", [lm, 1-tm+0.001, 1-lm-rm, 0.001]);
          axis off;
          title(ax, title_text);
        otherwise
          disp varargin{n};
          error("Unknown parameter label.");
        endswitch
        n++;
      endwhile
    return;
  endif
  
  ridx = varargin{1};
  cidx = varargin{2};
  fw = 1 - lm - rm; # figure width
  aw = (fw - hspacing*(ncolumns-1))/ncolumns;
  fh = 1 - bm - tm; # figure height
  ah = (fh - vspacing*(nrows-1))/nrows; # axes hight
  # [left, bottom, width, height]
  ft = 1 - tm; # figure top position
  p = [lm + (aw + hspacing)*(cidx-1), ft - (ah + vspacing)*(ridx) - vspacing, aw, ah];
  retval = subplot("position", p);
endfunction

%!test
%! func_name(x)
