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

function varargout = figuresize(varargin)
  if ! nargin
    print_usage();
  endif
  
  persistent default_size = get(gcf, "position")(3:4);

  n = 1;
  if isnumeric(varargin{1})
    if (length(varargin) > 1) && (isnumeric(varargin{2}))
      newsize = [varargin{1}, varargin{2}];
    else
      newsize = varargin{1};
    endif
    retval = __change_size__(newsize);
    if !isempty(retval) && nargout
      varargout = {retval};
    endif
    return
  endif
  
  opt = varargin{1};
  switch opt
    case "default"
      current_pos = get(gcf, "position");
      current_pos(3:4) = default_size;
      retval = __change_size__(default_size);
    otherwise
      retval = __settings__(opt, default_size);
  endswitch
  if !isempty(retval) && nargout
    varargout = {retval};
  endif
endfunction

function retval = __change_size__(newsize)
  retval = [];
  current_pos = get(gcf, "position");
  newpos = [current_pos(1:4-length(newsize)), newsize];
  if all(newpos(3:4) == current_pos(3:4))
    return
  endif
  newpos(2) = current_pos(2) + (current_pos(4) - newpos(4));
  set(gcf, "position", newpos);
  retval = newpos;
endfunction

function retval = __settings__(command, default_size)
  settings = struct("tall", 600, "wide", [800, 420] );
  retval = [];
  switch command
    case "list"
      current_pos = get(gcf, "position");
      for [v, key] = settings
        printf("%s : ", key);
        disp([current_pos(1:4-length(v)), v]);
      endfor
    otherwise
      v = settings.(command);
      retval = __change_size__(v);
      if !isempty(retval)
        printf("new figure position : ");
        disp(retval);
      endif
  endswitch
endfunction
%!test
%! figuresize(x)
