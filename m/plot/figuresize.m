## -*- texinfo -*-
## @deftypefn {Function File} {@var{figsize} =} figuresize(@var{width}, @var{height})
## Change figure size with specifing width and height.
##
## @deftypefnx {Function File} {@var{figsize} =} figuresize("default")
## Revert figure size to the default.
##
## @deftypefnx {Function File} {@var{figsize} =} figuresize("list")
## List pre-defined settings.
##
## @deftypefnx {Function File} {@var{figsize} =} figuresize(@var{setting_name})
## Choose a pre-defined setting to apply to the figure size.
##
## @end deftypefn

##== History
## 2015-02-20
## * enhanced. renamed to figuresize.
## 2014-11-13
## * first implementaion

function retval = figuresize(varargin)
  if ! nargin
    print_usage();
  endif
  
  persistent default_pos = get(gcf, "position");
  
  n = 1;
  if isnumeric(varargin{1})
    if (length(varargin) > 1) && (isnumeric(varargin{2}))
     retval = [default_pos(1:2), varargin{1}, varargin{2}];
    else
      retval = [default_pos(1:3), varargin{1}];
    endif
    set(gcf, "position", retval);
    return;
  endif
  
  opt = varargin{1};
  switch opt
    case "default"
      set(gcf, "position", default_pos);
      retval = default_pos;
      return;
    otherwise
      retval = __settings__(opt, default_pos);
      return;
  endswitch

endfunction

function retval = __settings__(command, defpos)
  settings = struct("tall", 600);
  switch command
    case "list"
      for [v, key] = settings
        printf("%s : ", key);
        disp([defpos(1:4-length(v)), v]);
      endfor
    otherwise
      v = settings.(command);
      newpos = [defpos(1:4-length(v)), v];
      set(gcf, "position", newpos);
      printf("new figure position : ");
      disp(newpos);
      retval = newpos;
  endswitch
endfunction
%!test
%! figuresize(x)
