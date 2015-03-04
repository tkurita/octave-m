## -*- texinfo -*-
## @deftypefn {Function File} {@var{obj} =} cod("BPM1", @var{v1}, ...)
## make a cod object with positions measured with BPMs.
## @deftypefnx {Function File} cod("kickers", {"kicker1, "kicker2", ...}, "kick_angles", @var{kick_angles})
## make a cod object with kick angles.
## @deftypefnx {Function File} cod("template", @var{template})
## set a template for new cod objects.
## 
## @strong{fields of cod object}
## @table @code
## @item ring
## ring object
## @item horv
## "h"(horizontal) or "v"(vertical)
## @item at_bpms
## a structure of BPM values.
## @end table
## 
##
## @end deftypefn

##== History
## 2013-11-26
## * first implementation

function obj = cod(varargin)
  persistent ring = NA;
  persistent template = NA;
  
  additionals = NA;
  switch nargin
    case 0
      # print_usage();
      return;
    case 1
      if isstruct(varargin{:})
        obj = varargin{:};
      elseif strcmp("template", varargin{1})
        obj = template;
        return
      else
        error("An argument must be a structure.");
      endif
    otherwise
      switch varargin{1}
        case "template"
          template = varargin{2};
          return
        otherwise
          if isstruct(template)
            obj = template;
          else
            obj.ring = ring;
          endif
          kickers = NA;
          at_bpms = NA;
          switch varargin{1}
            case "kickers"
              kickers = varargin{2};
              additionals = struct(varargin{3:end});
            otherwise
              at_bpms = struct(varargin{:});
          endswitch
          obj.kickers = kickers;
          obj.at_bpms = at_bpms;
      endswitch
  endswitch
  obj = class(obj, "cod");
  if isstruct(additionals)
    for [val, key] = additionals
      obj.(key) = val;
    endfor
  endif
endfunction

%!test
%! func_name(x)
