## -*- texinfo -*-
## @deftypefn {Function File} {} print_pdf(@var{fname}, [@var{opts}])
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
## 2014-07-22
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

function print_pdf(fname, varargin)
  [fs, fn, ps, pp, ax_pos, ort, margins, device] = get_properties(varargin,...
    {"fontsize", "fontname", "papersize", "paperposition", "position", "orient", "margins", "device"},
    {NA, NA,NA, NA, NA, NA, "10 10 10 10", "pdf"});

  #xy = [11, 8.5];
  #papersize = [8, 5];
  pre_orient = NA;
  if !isna(ort)
    pre_orient = orient;
    orient(ort);
  endif
  #pre_orient = orient;
  #orient("landscape");
  pre_ps = NA;
  if !isna(ps)
    pre_ps = get(gcf, "papersize");
    set(gcf, "papersize", ps);
  endif
  
  if isna(pp) && !isna(ps)
    pp = [0, 0, ps(1), ps(2)];
  endif
  
  pre_pp = NA;
  if !isna(pp)
    pre_pp =get(gcf, "paperposition");
    set(gcf, "paperposition", pp);
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
    if !isna(fn) set(xlabel_handles, "fontname", fn); endif
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
    if !isna(fn) set(ylabel_handles, "fontname", fn); endif
  endif
  
  ##=== fontname
  if !isna(fn)
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
  if !isna(pre_orient) orient(pre_orient); endif
  pdfcrop(fname, "margins", margins);
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
%! print_pdf(x)
