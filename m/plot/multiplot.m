## -*- texinfo -*-
## @deftypefn {Function File} {@var{hax} =} multiplot(@var{ridx},@var{cidx})
## @deftypefn {Function File} {} multiplot("layout", [@var{rows},@var{columns}])
## @deftypefnx {Function File} {} multiplot("margin", @var{margin})
## @deftypefnx {Function File} {} multiplot("horizontal spacing", @var{hs})
## @deftypefnx {Function File} {} multiplot("vertical spacing", @var{vs})
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
## If some figures vanish, fine adjust margins or spacing
## 
## @end deftypefn

function retval = multiplot(varargin)
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
  aw = (fw - hspacing*(ncolumns-1))/nrows;
  fh = 1 - bm - tm; # figure height
  ah = (fh - vspacing*(nrows-1))/nrows; # axes hight
  # [left, bottom, width, height]
  ft = 1 - tm; # figure top position
  retval = subplot("position", [lm + (aw + hspacing)*(cidx-1), ft - (ah + vspacing)*(ridx) - vspacing, aw, ah]);
endfunction

%!test
%! func_name(x)
