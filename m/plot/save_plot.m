## -*- texinfo -*-
## @deftypefn {Function File} {} save_plot(@var{fname}, [@var{opts}])
##
## Output plot as PDF file of which paper size fit the graphics.
##
## @strong{Available options}
## @table @code
## @item fontsize
## @item papersize
## @item paperposition
## @item position
## @item orient
## "landscape" or "portrat"
## @item margins
## The default is "10 10 10 10"
## @end table
##
## @end deftypefn

##== History
## 2014-11-11
## * revived "papersize" option.
## 2014-10-23
## * added "paperorientation" option.
## * improved "paperposition" setteing for gnuplot.
## 2014-10-01
## * paper is fit to figure. when paper orient is landscape.
## 2014-07-31
## * the device parameter is obtained from the path extension.
## * renamed from print_pdf.
## 2014-07-22
## * if device is not "pdf", pdfcrop will not be prformed.
## * support fontname property.
## 2014-04-10
## * utilize pdfcrop to make paper size fit the graphics.
## 2012-10-16
## * default paper size is changed to [8,5.5] from [8,5] to fit fltk output.
## 2012-07-27
## * if fontsize is not given, fontsize is not changed.
## 2011-07-28
## * "position" property can be cell array for multi-plot
## 2011-01-13
## * fixed : errors when one plot.
## 2011-01-06
## * fixed : "fontsize" are applied to plots in multiplot

function save_plot(fname, varargin)
  [fs, fn, ps, pp, po, ax_pos, ort, margins, device, crop] = get_properties(varargin,...
            {"fontsize", "fontname", ...
            "papersize", "paperposition", "paperorientation", "position", ... 
            "orient", "margins", "device", "crop"},...
            {NA, NA, NA, NA, NA, NA, "landscape", "10 10 10 10", NA, false});

  if !ischar(device)
    [d , bn, ext, v] = fileparts(fname);
    if !length(ext)
      error("device is not specified.");
    endif
    device = ext(2:end);
  endif

  pre_orient = NA;
  if ischar(ort)
    pre_orient = orient;
    orient(ort);
  endif

  pre_pp = get(gcf, "paperposition");
  pre_ps = get(gcf, "papersize");
  #if isna(pp) && isna(ps) && strcmp(ort, "landscape")
  if isna(pp) && strcmp(ort, "landscape")
    if (isna(po))
      if (strcmp(graphics_toolkit, "fltk"))
        po = [-0.15, -0.25];
      else
        po = [0, 0];
      endif
    endif
    if isna(ps)
      ps = [pre_pp(3), pre_pp(4)];
    endif
    pp = [po(1), po(2), ps(1), ps(2)];
    set(gcf, "paperposition", pp);
    set(gcf, "papersize", ps);
  endif
  
  ##=== axes position
  pre_axpos = NA;
  ax = findobj(gcf, "type", "axes");
  if (iscell(ax_pos))
    pre_axpos = get(ax, "position");
    apply_property(ax, "position", ax_pos);
#
#    if length(ax_list) > 1
#      pre_axpos = [];
#      for n = 1:length(ax)
#        pre_axpos(n,:) = get(ax{n}, "position");
#        set(ax{n}, "position", ax_pos(n,:));
#      endfor
#    else
#      pre_axpos = get(gca, "position");
#      set(gca, "position", ax_pos);
#    endif
  endif
  
  ##=== ticks label
  #pre_ticks = get(gca, "fontsize");
  pre_axfontsize = get(ax, "fontsize");
  #set(gca, "fontsize", fs); # axis ticks label
  if !isnan(fs) set(ax, "fontsize", fs); endif
  
  ##=== xlabel
  lh = get(ax, "xlabel");
  if iscell(lh)
    lh = cell2mat(lh);
  endif
  xlabel_handles = findobj(lh, "visible", "on");
  pre_xls = NA;
  if (length(xlabel_handles) > 0)
    pre_xls = get(xlabel_handles, "fontsize");
    if !isnan(fs) set(xlabel_handles, "fontsize", fs); endif
    if ischar(fn) set(xlabel_handles, "fontname", fn); endif
  endif
  

  #=== ylabel
  lh = get(ax, "ylabel");
  if iscell(lh)
    lh = cell2mat(lh);
  endif
  ylabel_handles = findobj(lh, "visible", "on");
  pre_yls = NA;
  if (length(ylabel_handles) > 0)
    pre_yls = get(ylabel_handles, "fontsize");
    if !isnan(fs) set(ylabel_handles, "fontsize", fs); endif
    if ischar(fn) set(ylabel_handles, "fontname", fn); endif
  endif
  
  ##=== fontname
  if ischar(fn)
    set(findobj(gcf, "-property", "fontname"), "fontname", fn);
  endif

  #print(["-d",device], fname); 
  if isnan(fs)
    print(["-d",device], fname);
  else
    print(["-F:", num2str(fs)], ["-d",device], fname);
  endif
    # gnuplot 4.2
    #  -F は legend だけに効く 
  
  ##=== recorver fontsize
  apply_property(ax, "fontsize", pre_axfontsize);
  if (iscell(pre_xls))
    apply_property(xlabel_handles, "fontsize", pre_xls);
  endif
  if (iscell(pre_yls))
    apply_property(ylabel_handles, "fontsize", pre_yls);
  endif
  
  if (iscell(pre_axpos))
    apply_property(ax, "position", pre_axpos);
    # set(gca, "position", pre_axpos);
  endif
  
  if !isna(pre_ps) set(gcf, "papersize", pre_ps); endif
  if !isna(pre_pp) set(gcf, "paperposition", pre_pp); endif
  if ischar(pre_orient) orient(pre_orient); endif
  if (crop && strcmp(device, "pdf"))
    # disp("will pdfcrop")
    pdfcrop(fname, "margins", margins);
  endif
endfunction

function apply_property(hs, propname, fs)
  if !iscell(fs)
    fs = {fs};
  endif
  for n = 1:length(hs)
    set(hs(n), propname, fs{n});
  endfor
endfunction

%!test
%! save_plot(x)
