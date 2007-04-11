function setup_output(filename)
  endl = ";\n";
  persistent origout;
  
  if (strcmp("pop", filename))
    plotterm("pop");
    if isempty (origout)
      __gnuplot_raw__ ("set output;\n")
    else
      __gnuplot_raw__ (["set output \"", origout, "\"", endl]);
    end
    
    return
  endif
  
  namelen = length(filename);
  if (namelen >= 4 ) 
    if !(strcmp(filename(namelen-3:end), ".pdf"))
      filename = [filename,".pdf"];
    endif
  else
    filename = [filename,".pdf"];
  endif
  
  origout = gget("output");
  plotterm("push");
  plotterm("pdf enhanced");
  __gnuplot_raw__ (["set output \"", filename, "\"", endl]);
endfunction