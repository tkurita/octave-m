## useage : setkey(optstring)
##
## wrapper function to set key(legend) of gnuplot
##
## = example
## setkey("outside box")
##
## set key {on|off} {default}
##       {left | right | top | bottom | outside | below | <position>}
##       {Left | Right} {{no}reverse}
##       {samplen <sample_length>} {spacing <vertical_spacing>}
##       {width <width_increment>}
##       {height <height_increment>}
##       {{no}autotitles}
##       {title "<text>"} {{no}enhanced}
##       {{no}box { {linestyle | ls <line_style>}
##                  | {linetype | lt <line_type>}
##                    {linewidth | lw <line_width>}}}

function setkey(optstring)
  if (nargin < 1) 
    __gnuplot_raw__ "unset key\n";
    return;
  endif
  
  eval (sprintf ("__gnuplot_set__ key %s;", optstring));
  
  if (automatic_replot)
    replot ();
  endif
  
endfunction
