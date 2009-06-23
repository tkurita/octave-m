## -*- texinfo -*-
## @deftypefn {Function File} {} default_osc_model(@var{modelname})
## 
## Get or set default model oscilloscope refered from "load_osc_csv".
##
## The default model is "DL1400".
##
## @seealso{load_osc_csv}
##
## @end deftypefn

##== History
## 2009-06-23
## * First implementation

function retval = default_osc_model(varargin)
  persistent modelname = "DL1400";
  if length(varargin)
    modelname = varargin{1};
  endif
  return modelname;
endfunction

%!test
%! default_osc_model(x)
