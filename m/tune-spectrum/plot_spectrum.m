## -*- texinfo -*-
## @deftypefn {Function File} {} plot_spectrum(@var{specdata}, @var{options})
##
## Plot spectrum data @var{specdata} which is returned by load_spectrum_csv.
##
## Options
##
## @table @code
## @item "x"
## A field name of @var{specdata}. "MHz" or "Hz".
## The default is "MHz".
## @item "y"
## A field name of @var{specdata} (ex. "msec") or "frame".
## The default is "msec".
## @item "gpscript"
## A fiel name to output to a gnuplot script file instead of plot. 
## Because octave can't deal with uneven 3d data.
## @end table
##
## @end deftypefn

##== History
## 2009-06-08
## * add "usepcolor" option
## * add "frameindex" and "frametime" options.
##
## 2009-06-01
## * renamed from plotSgram
## * support ver. 3

function plot_spectrum(specdata, varargin);
  if (!nargin)
    print_usage();
  endif
  opts = get_properties(varargin,...
  {"x", "y", "gpscript", "frametime", "frameindex", "colorbar", "usepcolor"},...
  {"MHz", "msec", NA, NA, NA, true, false});
                        
  if (strcmp(opts.y, "frame"))
    [x, z] = getfields(specdata, opts.x, "dBm");
    y = 1:rows(z);    
  else
    if (!isfield(specdata, opts.y))
      error(sprintf("%s is unknown Y value", opts.y));
    endif
    [x, y, z] = getfields(specdata, opts.x, opts.y, "dBm");
  endif
  #cblabel("dBm")
  #__gnuplot_raw__("set palette rgbformulae 30,13,-31\n");
  #contourMap3d(x, y, z);
  if (isna(opts.gpscript))
    if (!isna(opts.frameindex))
      subplot(2,1,1);
      xyplot(frame_spectrum_at(specdata, "frame", opts.frameindex), "-");
      ylabel("[dBm]");
      subplot(2,1,2);
      opts.colorbar = false;
    elseif (!isna(opts.frametime))
      subplot(2,1,1);
      xyplot(frame_spectrum_at(specdata, "time", opts.frametime), "-");
      ylabel("[dBm]");
      subplot(2,1,2);
      opts.colorbar = false;
    endif
    
    if opts.usepcolor
      pcolor(x, y, z);
      shading("flat");
      view(0, -90);
      tics("z", [], []);
    else
      imagesc(x, y, z);
    endif
    colormap(jet());
    ylabel_text = sprintf("[%s]",opts.y);
    ylabel(ylabel_text);
    xlabel_text = sprintf("[%s]",opts.x);
    xlabel(xlabel_text);
    if opts.colorbar
      colorbar();
    endif
    return;
  endif
  
  fid = fopen(opts.gpscript, "w");
  #set palette rgbformulae 30,13,-31
  fprintf(fid, "%s\n", "set palette rgbformulae 22,13,-31");
  fprintf(fid, "%s\n", "set pm3d map");
  fprintf(fid, "%s\n", "set parametric");
  fprintf(fid, "%s \"[%s]\"\n", "set xlabel", opts.x);
  fprintf(fid, "%s \"[%s]\"\n", "set ylabel", opts.y);
  fprintf(fid, "%s\n", "set yrange [*:*] reverse");
  fprintf(fid, "%s\n", "splot \"-\"");
  
  for n = 1:rows(z)
    # n = 1;
    # fid = stdout;
    outmat = [x(:)';
              ones(1,length(x))*y(n);
              z(n, :)];
    outmat(:,any(isna(outmat),1)) = [];
    fprintf(fid, "%g\t%g\t%g\n",outmat);
    fprintf(fid, "\n");
  endfor
  fclose(fid);
endfunction