## -*- texinfo -*-
## @deftypefn {Function File} {@var{result} =} print_pdf(@var{fname})
##
## Output plot as PDF file of which font size is 10 and size is 8,5.
##
## @end deftypefn

##== History
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
  if (!isna(ax_pos))
    pre_axpos = get(gca, "position");
    set(gca, "position", ax_pos);
  endif
  
  ##=== ticks label
  ax = findobj(gcf, "type", "axes");
  #pre_ticks = get(gca, "fontsize");
  pre_axfontsize = get(ax, "fontsize");
  #set(gca, "fontsize", fs); # axis ticks label
  set(ax, "fontsize", fs);
  
  ##=== xlabel
  xlabel_handles = findobj(cell2mat(get(ax, "xlabel")), "visible", "on");
  pre_xls = NA;
  if (length(xlabel_handles) > 0)
    pre_xls = get(xlabel_handles, "fontsize");
    set(xlabel_handles, "fontsize", fs);
  endif
  

  #=== ylabel
  ylabel_handles = findobj(cell2mat(get(ax, "ylabel")), "visible", "on");
  pre_yls = NA;
  if (length(ylabel_handles) > 0)
    pre_yls = get(ylabel_handles, "fontsize");
    set(ylabel_handles, "fontsize", fs);
  endif

  print(["-F:", num2str(fs)], ["-d",device], fname); 
    # gnuplot 4.2
    #  -F は legend だけに効く 
  
  ##=== recorver fontsize
  recover_property(ax, "fontsize", pre_axfontsize);
  if (iscell(pre_xls))
    recover_property(xlabel_handles, "fontsize", pre_xls);
  endif
  if (iscell(pre_yls))
    recover_property(ylabel_handles, "fontsize", pre_yls);
  endif
  if (iscell(pre_axpos))
    pre_axpos
    set(gca, "position", pre_axpos);
  endif
  set(gcf, "papersize", pre_ps);
  set(gcf, "paperposition", pre_pp);
  orient(pre_orient);
endfunction

function recover_property(hs, propname, fs)
  for n = 1:length(hs)
    set(hs(n), propname, fs{n});
  endfor
endfunction

%!test
%! print_pdf(x)
