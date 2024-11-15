## -*- texinfo -*-
## @deftypefn {Function File} {} plot_tunespectrum(@var{specdata})
##
## Convert frequency spectrum to tune spectrum.
##
## @table @code
## @item @var{specdata}
## output of split_spectrum
## @item @var{frevtrace}
## output of trace_peak_spectrum
## @item @var{func}
## function to calculate tune from frequency.
## @example
## inline("+-(f./frev +-m)")
## @end example
## @end table
##
## Options
## @table @code
## @item "output"
## filename including data and gnuplot commands
## If this option is omitted, pcolor is used to plot.
## @item "xlabel"
## The default is "{/Symbol n}".
## @end table
## 
## @end deftypefn

##== History
## 2009-06-08
## * Use pcolor when "output" option is ommited.

function plot_tunespectrum(specdata, frevtrace, func, varargin)
  # frevtrace = peaktrace1;
  # specdata = spec_lr{1};
  # f = inline("f./frev")
  if (!nargin)
    print_usage();
    return;
  endif
  
  opts = get_properties(varargin,...
                      {"output", "xlabel"},...
                      {NA, "{/Symbol n}"});
  tlen = length(frevtrace.t);
  flen = length(specdata.MHz);
  numat = func(repmat(specdata.MHz(:)',tlen ,1),...
             repmat(frevtrace.freq(:),1 , flen));
  
  if isna(opts.output)
    pcolor(numat, repmat(specdata.msec(:), 1, flen), specdata.dBm);
    xlabel(opts.xlabel);
    ylabel("[msec]");
    shading("flat");
    view(0, -90);
    tics("z", [], []);
  else
    fid = fopen(opts.output, "w");
    #set palette rgbformulae 30,13,-31
    fprintf(fid, "%s\n", "set palette rgbformulae 22,13,-31");
    fprintf(fid, "%s\n", "set pm3d map");
    fprintf(fid, "%s\n", "set parametric");
    fprintf(fid, "%s \"%s\"\n", "set xlabel",opts.xlabel);
    fprintf(fid, "%s\n", "set ylabel \"[msec]\"");
    fprintf(fid, "%s\n", "set yrange [*:*] reverse");
    fprintf(fid, "%s\n", "splot \"-\"");
    
    for n = 1:rows(numat)
      # n = 1;
      # fid = stdout;
      outmat = [numat(n,:);
                ones(1,flen)*specdata.msec(n);
                specdata.dBm(n,:)];
      outmat(:,any(isna(outmat),1)) = [];
      fprintf(fid, "%g\t%g\t%g\n",outmat);
      fprintf(fid, "\n");
    endfor
    fclose(fid);
    system(sprintf("gnuplot -persist %s", opts.output));
  endif
endfunction

%!test
%! nu_with_spectrum(x)
