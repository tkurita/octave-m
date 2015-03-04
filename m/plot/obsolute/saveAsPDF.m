## obsolute
## 2006-11-01
## * print(filename, "-dpdf") を使う

function saveAsPDF(filename)
  namelen = length(filename);
  if (namelen >= 4 ) 
    if !(strcmp(filename(namelen-3:end), ".pdf"))
      filename = [filename,".pdf"];
    endif
  else
    filename = [filename,".pdf"];
  endif
  
  origout = gget("output");
  _automatic_replot = automatic_replot;
  endl = ";\n";
  plotterm("push");
  unwind_protect
    automatic_replot = 0;
    plotterm("pdf enhanced");
    __gnuplot_raw__ (["set output \"", filename, "\"", endl]);
    __gnuplot_replot__
  unwind_protect_cleanup
    plotterm("pop");
    if isempty (origout)
      __gnuplot_raw__ ("set output;\n")
    else
      __gnuplot_raw__ (["set output \"", origout, "\"", endl]);
    end
    __gnuplot_replot__
    
    automatic_replot = _automatic_replot ;
  end_unwind_protect
endfunction