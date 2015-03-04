function multixyplot(plotRecArray, output)
  unwind_protect
    if (nargin > 1)
      oneplot();
      setup_output(output)
    endif
    
    plotNumMat = size(plotRecArray);
    
    # oneplot();
    multiplot(plotNumMat(2),plotNumMat(1));
    for n = 1:plotNumMat(1)
      for m = 1:plotNumMat(2)
        mxyplot(plotRecArray{n,m})
      endfor
    endfor
    
  unwind_protect_cleanup
    if (nargin > 1)
      oneplot()
      setup_output("pop")
    endif
  end_unwind_protect
endfunction
