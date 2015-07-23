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
## * added "paperorigin" option.
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
  p = inputParser();
  p.FunctionName = "save_plot";
  p = p.addParamValue("fontsize", NA);
  p = p.addParamValue("fontname", NA);
  p = p.addParamValue("papersize", NA);
  p = p.addParamValue("paperposition", NA);
  p = p.addParamValue("paperorigin", NA);
  p = p.addParamValue("position", NA);
  p = p.addParamValue("orient", "landscape");
  p = p.addParamValue("margins", "10 10 10 10");
  p = p.addParamValue("device", NA);
  p = p.addParamValue("crop", false);
  p = p.parse(varargin{:});
  opts = p.Results;

  if !ischar(opts.device)
    [d , bn, ext, v] = fileparts(fname);
    if !length(ext)
      error("device is not specified.");
    endif
    opts.device = ext(2:end);
  endif

  pre_orient = NA;
  if ischar(opts.orient)
    pre_orient = orient;
    orient(opts.orient);
  endif

  pre_pp = get(gcf, "paperposition");
  pre_ps = get(gcf, "papersize");

  if isna(opts.paperposition) && strcmp(opts.orient, "landscape")
    if (isna(opts.paperorigin))
      if (strcmp(graphics_toolkit, "fltk"))
        opts.paperorigin = [-0.15, -0.25];
      else
        opts.paperorigin = [0, 0];
      endif
    endif
    if isna(opts.papersize)
      opts.papersize = [pre_pp(3), pre_pp(4)];
    endif
    opts.paperposition = ...
    [opts.paperorigin(1), opts.paperorigin(2), opts.papersize(1), opts.papersize(2)];
    opts
    set(gcf, "paperposition", opts.paperposition);
    set(gcf, "papersize", opts.papersize);
  endif
  
  ##=== axes position
  pre_axpos = NA;
  ax = findobj(gcf, "type", "axes");
  if (iscell(opts.position))
    pre_axpos = get(ax, "position");
    apply_property(ax, "position", opts.position);
#
#    if length(ax_list) > 1
#      pre_axpos = [];
#      for n = 1:length(ax)
#        pre_axpos(n,:) = get(ax{n}, "position");
#        set(ax{n}, "position", opts.position(n,:));
#      endfor
#    else
#      pre_axpos = get(gca, "position");
#      set(gca, "position", opts.position);
#    endif
  endif
  
  ##=== ticks label
  #pre_ticks = get(gca, "fontsize");
  pre_axfontsize = get(ax, "fontsize");
  #set(gca, "fontsize", opts.fontsize); # axis ticks label
  if !isnan(opts.fontsize) set(ax, "fontsize", opts.fontsize); endif
  
  ##=== xlabel
  lh = get(ax, "xlabel");
  if iscell(lh)
    lh = cell2mat(lh);
  endif
  xlabel_handles = findobj(lh, "visible", "on");
  pre_xls = NA;
  if (length(xlabel_handles) > 0)
    pre_xls = get(xlabel_handles, "fontsize");
    if !isnan(opts.fontsize) set(xlabel_handles, "fontsize", fontsize); endif
    if ischar(opts.fontname) set(xlabel_handles, "fontname", opts.fontname); endif
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
    if !isnan(opts.fontsize) set(ylabel_handles, "fontsize", opts.fontsize); endif
    if ischar(opts.fontname) set(ylabel_handles, "fontname", opts.fontname); endif
  endif
  
  ##=== fontname
  if ischar(opts.fontname)
    set(findobj(gcf, "-property", "fontname"), "fontname", opts.fontname);
  endif

  #print(["-d",opts.device], fname); 
  if isnan(opts.fontsize)
    print(["-d",opts.device], fname);
  else
    print(["-F:", num2str(opts.fontsize)], ["-d",opts.device], fname);
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
  if (opts.crop && strcmp(opts.device, "pdf"))
    # disp("will pdfcrop")
    pdfcrop(fname, "margins", opts.margins);
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
