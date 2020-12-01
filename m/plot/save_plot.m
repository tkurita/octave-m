## -*- texinfo -*-
## @deftypefn {Function File} {} save_plot(@var{fname}, [@var{opts}])
##
## Output plot as PDF file of which paper size fit the graphics.
##
## For gnuplot, "dpi", 144, "fontsize", 10 is closed to screen.
## 
## @strong{Available options}
## @table @code
## @item fontsize
## @item papersize
## in inch. default value is "screen". 72dpi.
## @item paperposition
## @item position
## @item orient
## "landscape" or "portrat"
## @item margins
## The default is "10 10 10 10"
## @end table
##
## @end deftypefn

function save_plot(fname, varargin)
  p = inputParser();
  p.FunctionName = "save_plot";
  p.addParamValue("fontsize", NA);
  p.addParamValue("fontname", NA);
  p.addParamValue("papersize", "screen");
  p.addParamValue("paperposition", NA);
  p.addParamValue("paperorigin", NA);
  p.addParamValue("position", NA);
  p.addParamValue("orient", "landscape");
  p.addParamValue("margins", "10 10 10 10");
  p.addParamValue("device", NA);
  p.addParamValue("crop", false);
  p.addParamValue("dpi", 72);
  
  p.parse(varargin{:});

  opts = p.Results;

  if !ischar(opts.device)
    # fname
    [d , bn, ext] = fileparts(fname);
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
    if !ischar(opts.papersize)
      opts.papersize = [pre_pp(3), pre_pp(4)];
    else strcmp(opts.papersize, "screen");
      fps = get(gcf, "position");
      opts.papersize = [fps(3), fps(4)]./opts.dpi;
      if (isna(opts.paperorigin))
        opts.paperorigin = [0, 0];
      endif
    endif

    if (isna(opts.paperorigin))
      if (strcmp(graphics_toolkit, "fltk"))
        opts.paperorigin = [-0.15, -0.25];
      else
        opts.paperorigin = [0, 0];
      endif
    endif

    opts.paperposition = ...
    [opts.paperorigin(1), opts.paperorigin(2), opts.papersize(1), opts.papersize(2)];
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
    if !isnan(opts.fontsize) set(xlabel_handles, "fontsize", opts.fontsize); endif
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
