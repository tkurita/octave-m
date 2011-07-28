## -*- texinfo -*-
## @deftypefn {Function File} {@var{result} =} print_pdf(@var{fname})
##
## Output plot as PDF file of which font size is 10 and size is 8,5.
##
## @end deftypefn

##== History
## 2011-07-28
## * "position" property can be cell array for multi-plot
## 2011-01-13
## * fixed : errors when one plot.
## 2011-01-06
## * fixed : "fontsize" are applied to plots in multiplot

function retval = print_pdf(fname, varargin)
  [fs, ps, pp, ax_pos, device] = get_properties(varargin,...
    {"fontsize", "papersize", "paperposition", "position", "device"},
    {10, [8,5], NA, NA, "pdf"});
  #xy = [11, 8.5];
  #papersize = [8, 5];
  pre_orient = orient;
  orient("landscape");
  pre_ps = get(gcf, "papersize");
  set(gcf, "papersize", ps);
  pre_pp =get(gcf, "paperposition");
  if isna(pp)
    pp = [0, 0, ps(1), ps(2)];
  endif
  set(gcf, "paperposition", pp);

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
  set(ax, "fontsize", fs);
  
  ##=== xlabel
  lh = get(ax, "xlabel");
  if iscell(lh)
    lh = cell2mat(lh);
  endif
  xlabel_handles = findobj(lh, "visible", "on");
  pre_xls = NA;
  if (length(xlabel_handles) > 0)
    pre_xls = get(xlabel_handles, "fontsize");
    set(xlabel_handles, "fontsize", fs);
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
    set(ylabel_handles, "fontsize", fs);
  endif

  print(["-F:", num2str(fs)], ["-d",device], fname); 
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
  set(gcf, "papersize", pre_ps);
  set(gcf, "paperposition", pre_pp);
  orient(pre_orient);
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
