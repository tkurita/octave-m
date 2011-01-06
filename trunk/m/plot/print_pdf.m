## -*- texinfo -*-
## @deftypefn {Function File} {@var{result} =} print_pdf(@var{fname})
##
## Output plot as PDF file of which font size is 10 and size is 8,5.
##
## @end deftypefn

##== History
##

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
  pre_ticks = get(gca, "fontsize");
  set(gca, "fontsize", fs); # axis ticks label

  ##=== xlabel
  xl = get(gca, "xlabel");
  pre_xls = NA;
  if (strcmp(get(xl, "visible"), "on"))
    pre_xsl = get(xl, "fontsize");
    set(xl, "fontsize", fs);
  endif

  #=== ylabel
  yl = get(gca, "ylabel");
  pre_yls = NA;
  if (strcmp(get(yl, "visible"), "on"))
    pre_ysl = get(yl, "fontsize");
    set(yl, "fontsize", fs);
  endif
  
  print(["-F:", num2str(fs)], ["-d",device], fname); 
    # gnuplot 4.2
    #  -F は legend だけに効く 
  
  ##=== recorver fontsize
  set(gca, "fontsize", pre_ticks);
  if (!isna(pre_xsl))
    set(xl, "fontsize", pre_xsl);
  endif
  if (!isna(pre_ysl))
    set(yl, "fontsize", pre_ysl);
  endif
  set(gca, "fontsize", pre_ticks);
  if (!isnan(pre_axpos))
    pre_axpos
    set(gca, "position", pre_axpos);
  endif
  set(gcf, "papersize", pre_ps);
  set(gcf, "paperposition", pre_pp);
  orient(pre_orient);
endfunction

%!test
%! print_pdf(x)
