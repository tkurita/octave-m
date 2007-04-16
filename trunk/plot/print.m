## Copyright (C) 2001 Laurent Mazet
##
## This program is free software; it is distributed in the hope that it
## will be useful, but WITHOUT ANY WARRANTY; without even the implied
## warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See
## the GNU General Public License for more details.
##
## You should have received a copy of the GNU General Public License
## along with this file; see the file COPYING.  If not, write to the
## Free Software Foundation, 59 Temple Place - Suite 330, Boston, MA
## 02111-1307, USA.
##
## Copyright (C) 1999 Daniel Heiserer

## -*- texinfo -*-
## @deftypefn {Function File} {} print (@var{filename}, @var{options})
##
## Print a graph, or save it to a file
##
## @var{filename} defines the file name of the output file. If no
## filename is specified, output is sent to the printer.
##
## @var{options}:
## @table @code
## @item -P@var{printer}
##   Set the @var{printer} name to which the graph is sent if no
##   @var{filename} is specified.
## @item -color
## @itemx -mono
##   Monochrome or colour lines.
## @item -solid
## @itemx -dashed
##   Solid or dashed lines.
## @item -portrait
## @itemx -landscape
##   Plot orientation, as returned by "orient".
## @item -d@var{device}
##   Output device, where @var{device} is one of:
##   @table @code
##   @item ps
##   @itemx ps2
##   @itemx psc
##   @itemx psc2
##     Postscript (level 1 and 2, mono and color)
##   @item eps
##   @itemx eps2
##   @itemx epsc
##   @itemx epsc2
##     Encapsulated postscript (level 1 and 2, mono and color)
##   @item pdf
##     Portable document format
##   @item ill
##   @itemx aifm
##     Adobe Illustrator
##   @item cdr
##   @itemx corel
##     CorelDraw
##   @item hpgl
##     HP plotter language
##   @item fig
##     XFig
##   @item dxf
##     AutoCAD
##   @item mf
##     Metafont
##   @item png
##     Portable network graphics
##   @item pbm
##     PBMplus
##   @end table
##
##   Other devices are supported by "convert" from ImageMagick.  Type
##   system("convert") to see what formats are available.
##
##   If the device is omitted, it is inferred from the file extension,
##   or if there is no filename it is sent to the printer as postscript.
##
## @item -F@var{fontname}
## @itemx -F@var{fontname}:@var{size}
## @itemx -F:@var{size}
##   @var{fontname} set the postscript font (for use with postscript,
##   aifm, corel and fig). By default, 'Helvetica' is set for PS/Aifm,
##   and 'SwitzerlandLight' for Corel. It can also be 'Times-Roman'.
##   @var{size} is given in points. @var{fontname} is ignored for the
##   fig device.
## @end table
##
## The filename and options can be given in any order.
##
## If you are using Octave 2.1.x or above, command("print") will change 
## print from a function to a command, so instead of typing
##    print("-FTimes-Roman:14", "-dashed", "-depsc", "out.ps")
## you can type
##    print -FTimes-Roman:14 -dashed -depsc out.ps
##
## See also: orient, command
## @end deftypefn

## Author: Daniel Heiserer <Daniel.heiserer@physik.tu-muenchen.de>
## 2001-03-23  Laurent Mazet <mazet@crm.mot.com>
##     * simplified interface: guess the device from the extension
##     * font support
## 2001-03-25  Paul Kienzle <pkienzle@kienzle.powernet.co.uk>
##     * add unwind_protect
##     * use tmpnam to generate temporary name
##     * move "set term" before "set output" as required by gnuplot
##     * more options, and flexible options
## 2001-03-29  Laurent Mazet <mazet@crm.mot.com>
##     * add solid and dashed options
##     * change PBMplus device
##     * add Corel device
##     * take care of the default terminal settings to restore them.
##     * add color, mono, dashed and solid support for printing and convert.
##     * add orientation for printing.
##     * create a .ps for printing (avoid some filtering problems).
##     * default printing is mono, default convert is color.
##     * add font size support.
## 2001-03-30  Laurent Mazet <mazet@crm.mot.com>
##     * correct correl into corel
##     * delete a irrelevant test
##     * check for convert before choosing the ouput device
## 2001-03-31  Paul Kienzle <pkienzle@kienzle.powernet.co.uk>
##     * use -Ffontname:size instead of -F"fontname size"
##     * add font size support to fig option
##     * update documentation
## 2003-10-01  Laurent Mazet <mazet@crm.mot.com>
##     * clean documentation

## PKG_ADD mark_as_command('print')

## 2007-04-13
## * tell gnuplot to cd to synchronize current working directory
## 2006-11-01
## * add enhanced for teminal pdf

function print(varargin)
  __gnuplot_raw__(sprintf("cd '%s'\n",pwd)); #2007-04-13 tkurita
  ## take care of the settings we had before
  origterm = gget("terminal");
  origout = gget("output");
  ## End of line trmination for __gnuplot_raw__ command strings.
  endl = ";\n";
  _automatic_replot = automatic_replot;
  
  ## take care of the default terminal settings to restore them.
  terminal_default = "";
  
  orientation = orient;
  use_color = 0; # 0=default, -1=mono, +1=color
  force_solid = 0; # 0=default, -1=dashed, +1=solid
  use_enhanced = true;
  
  fontsize = font = name = devopt = printer = "";
  
  va_arg_cnt = 1;
  
  for i=1:nargin
    arg = nth (varargin, va_arg_cnt++);
    if ischar(arg)
      if strcmp(arg, "-color")
        use_color = 1;
      elseif strcmp(arg, "-mono")
        use_color = -1;
      elseif strcmp(arg, "-solid")
        force_solid = 1;
      elseif strcmp(arg, "-dashed")
        force_solid = -1;
      elseif strcmp(arg, "-portrait")
        orientation = "portrait";
      elseif strcmp(arg, "-landscape")
        orientation = "landscape";
      elseif strcmp(arg, "-enhanced") # 2006-12-13 tkurita
        use_enhanced = true;             # 2006-12-13 tkurita
      elseif strcmp(arg, "-noenhanced") # 2006-12-13 tkurita
        use_enhanced = false;             # 2006-12-13 tkurita  
      elseif length(arg) > 2 && arg(1:2) == "-d"
        devopt = arg(3:length(arg));
      elseif length(arg) > 2 && arg(1:2) == "-P"
        printer = arg;
      elseif length(arg) > 2 && arg(1:2) == "-F"
        idx = rindex(arg, ":");
        if (idx)
          font = arg(3:idx-1);
          fontsize = arg(idx+1:length(arg));
        else
          font = arg(3:length(arg));
        endif
      elseif length(arg) >= 1 && arg(1) == "-"
        error([ "print: unknown option ", arg ]);
      elseif length(arg) > 0
        name = arg;
      endif
    else
      error("print: expects string options");
    endif
  endfor
  
  doprint = isempty(name);
  if doprint
    if isempty(devopt)
      printname = [ tmpnam, ".ps" ]; 
    else
      printname = [ tmpnam, ".", devopt ];
    endif
    name = printname;
  endif
  
  if isempty(devopt)
    dot = rindex(name, ".");
    if (dot == 0) 
      error ("print: no format specified");
    else
      dev = tolower(name(dot+1:length(name)));
    endif
  else
    dev = devopt;
  endif
  
  if strcmp(dev, "ill")
    dev = "aifm";
  elseif strcmp(dev, "cdr")
    dev = "corel";
  endif
  
  ## check if we have to use convert
  dev_list = [" aifm corel fig png pbm dxf mf hpgl", ...
  " pdf ps ps2 psc psc2 eps eps2 epsc epsc2 " ];
  convertname = "";
  if isempty(findstr(dev_list , [ " ", dev, " " ]))
    if !isempty(devopt)
      convertname = [ devopt ":" name ];
    else
      convertname = name;
    endif
    dev = "epsc";
    name = [ tmpnam, ".eps" ];
  endif
  
  unwind_protect
    automatic_replot = 0;
    
    if strcmp(dev, "ps") || strcmp(dev, "ps2") ...
      || strcmp(dev, "psc")  || strcmp(dev, "psc2") ...
      || strcmp(dev, "epsc") || strcmp(dev, "epsc2") ... 
      || strcmp(dev, "eps")  || strcmp(dev, "eps2")
      ## Various postscript options
      ## FIXME: Do we need this? DAS
      ##__gnuplot_set__ term postscript
      terminal_default = gget ("terminal");
      
      if dev(1) == "e"
        options = "eps ";
      else
        options = [ orientation, " " ];
      endif
      options = [ options, "enhanced " ];
      
      if any( dev == "c" ) || use_color > 0
        if force_solid < 0
          options = [ options, "color dashed " ];
        else
          options = [ options, "color solid " ];
        endif
      else
        if force_solid > 0
          options = [ options, "mono solid " ];
        else
          options = [ options, "mono dashed " ];
        endif
      endif
      
      if !isempty(font)
        options = [ options, "\"", font, "\" " ];
      endif
      if !isempty(fontsize)
        options = [ options, fontsize, " " ];
      endif
      
      __gnuplot_raw__ (["set term postscript ", options, endl]);
      
      
    elseif strcmp(dev, "pdf")
      ## Portable document format
      terminal_default = gget ("terminal");
      if (use_enhanced)
        options = " enhanced";
      else
        options = " noenhanced";
      endif
      
      if !isempty(font)
        options = [ options, " \"", font, "\"" ];
      endif
      if !isempty(fontsize)
        options = [ options, " ", fontsize ];
      endif
      #["set term pdf", options, endl]
      __gnuplot_raw__ (["set term pdf", options, endl]);
      
    elseif strcmp(dev, "aifm") || strcmp(dev, "corel")
      ## Adobe Illustrator, CorelDraw
      ## FIXME: Do we need it? DAS
      ## eval(sprintf ("__gnuplot_set__ term %s", dev));
      terminal_default = gget ("terminal");
      if (use_color >= 0)
        options = " color";
      else
        options = " mono";
      endif
      if !isempty(font)
        options = [ options, " \"" , font, "\"" ];
      endif
      if !isempty(fontsize)
        options = [ options, " ", fontsize ];
      endif
      
      __gnuplot_raw__ (["set term ", dev, " ", options, endl]);
      
    elseif strcmp(dev, "fig")
      ## XFig
      ## FIXME: Do we need it? DAS
      ## __gnuplot_set__ term fig
      terminal_default = gget ("terminal");
      options = orientation;
      if (use_color >= 0)
        options = " color";
      else
        options = " mono";
      endif
      if !isempty(fontsize)
        options = [ options, " fontsize ", fontsize ];
      endif
      __gnuplot_raw__ (["set term fig ", options, endl]);
      
    elseif strcmp(dev, "png") || strcmp(dev, "pbm")
      ## Portable network graphics, PBMplus
      ## FIXME: Do we need it? DAS
      ## eval(sprintf ("__gnuplot_set__ term %s", dev));
      terminal_default = gget ("terminal");
      
      ## FIXME
      ## New PNG interface takes color as "xRRGGBB" where x is the literal character
      ## 'x' and 'RRGGBB' are the red, green and blue components in hex.
      ## For now we just ignore it and use default. 
      ## The png terminal now is so rich with options, that one perhaps
      ## has to write a separate printpng.m function.
      ## DAS
      
      ##
      ## if (use_color >= 0)
      ##	eval (sprintf ("__gnuplot_set__ term %s color medium", dev));
      ##else
      ##eval (sprintf ("__gnuplot_set__ term %s mono medium", dev));
      ##endif
      
      __gnuplot_raw__ ("set term png large;\n")
      
    elseif strcmp(dev,"dxf") || strcmp(dev,"mf") || strcmp(dev, "hpgl")
      ## AutoCad DXF, METAFONT, HPGL
      __gnuplot_raw__ (["set terminal ", dev, endl]);
      
    endif;
    
    ## Gnuplot expects " around output file name
    
    __gnuplot_raw__ (["set output \"", name, "\"", endl]);
    __gnuplot_replot__
    
  unwind_protect_cleanup
    
    ## Restore init state
    if ! isempty (terminal_default)
      __gnuplot_raw__ (["set terminal ", terminal_default, endl]);
    endif
    __gnuplot_raw__ (["set terminal ", origterm, endl]);
    if isempty (origout)
      __gnuplot_raw__ ("set output;\n")
    else
      ## Gnuplot expects " around output file name
      
      __gnuplot_raw__ (["set output \"", origout, "\"", endl]);
    end
    __gnuplot_replot__
    
    automatic_replot = _automatic_replot ;
    
  end_unwind_protect
  
  if !isempty(convertname)
    command = [ "convert '", name, "' '", convertname, "'" ];
    [output, errcode] = system (command);
    unlink (name);
    if (errcode)
      error ("print: could not convert");
    endif
  endif
  ## FIXME: This looks like a dirty, Unix-specific hack
  ## DAS
  if doprint
    system(sprintf ("lpr %s '%s'", printer, printname));
    unlink(printname);
  endif
  
endfunction
