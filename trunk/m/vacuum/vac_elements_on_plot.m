## -*- texinfo -*-
## @deftypefn {Function File} {@var{result} =} vac_elements_on_plot(@var{arg})
##
## @end deftypefn

##== History
##

function retval = vac_elements_on_plot(varargin)
  [ds, clear_flag, yposition] = get_properties(varargin,...
                            {"origin", "clear", "yposition"},...
                            {0, false, "graph 0"});
  if (clear_flag)
    #text();
    children = get(gca, "children");
    for n =1:length(children)
      if (strcmp(get(children(n), "type"), "text"))
        delete(children(n));
      endif
    endfor
  endif
  
  y_lim = get(gca(), "ylim");
  if (ischar(yposition))
    [s, e, te, m, t, nm] = regexp(yposition, "(\\w+)\\s(-?\\d*.*)");
    if (s > 0)
      switch t{1}{1}
        case "first"
          yposition = str2num(t{1}{2});
        case "graph"
          yposition = str2num(t{1}{2});
          yposition = y_lim(1) + (y_lim(2) - y_lim(1))*yposition;
        otherwise
          error("value of yposition is invalid.");
      endswitch
    else
      error("value of yposition is invalid.");
    endif
  endif
  
  vacelems = vac_elements(ds);
  for n = 1:rows(vacelems)
    if (regexp(vacelems{n,1}, "^IG"))
      y = yposition+ (y_lim(2) - y_lim(1))*0.1;
    elseif (regexp(vacelems{n,1}, "^TMP"))
      y = yposition+ (y_lim(2) - y_lim(1))*0.02;
    else
      y = yposition;
    endif
    #[vacelems{n,2}, y]
    text(vacelems{n,2}, y, vacelems{n,1}, "rotation", 90);
  endfor
endfunction

%!test
%! func_name(x)
