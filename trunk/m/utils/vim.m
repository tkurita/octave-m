## -*- texinfo -*-
## @deftypefn {Function File} {} vim()
## @deftypefnx {Function File} {} vim("on")
## @deftypefnx {Function File} {} vim("off")
## 
## Use vim as pager.
##
## If "off" is passed, the pager settings revert to the original.
## 
## @end deftypefn

##== History
## 2008-03-15
## * first implementaion

function vim(varargin)
  persistent pager_saved;
  persistent pager_flags_saved;
  
  if (isempty(pager_saved))
    pager_saved = PAGER();
    pager_flags_saved = PAGER_FLAGS();
  end
  
  if (length(varargin) > 0)
    action = varargin{1};
  else
    if (strcmp(PAGER(), "vim"))
      action = "off";
    else
      action = "on";
    end
  end
  
  switch action
    case "off"
      PAGER(pager_saved);
      PAGER_FLAGS(pager_flags_saved);
    case "on"
      PAGER("vim");
      #PAGER_FLAGS("-R -");
      PAGER_FLAGS("-");
    otherwise
      error("%s is unknown command.", varargin{1});
  endswitch
  
endfunction