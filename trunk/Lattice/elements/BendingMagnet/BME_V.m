## -*- texinfo -*-
## @deftypefn {Function File} {@var{mat} =} BME_V(@var{radius} @var{edgeangle} [,@var{p_error}])
##
## vertical edge matrix of bending magnet
## 
## "pError" : momentum error
##
## "vedge" : 磁極端部でビーム進行方向に徐々に磁場が弱くなる効果を考慮
## 
## @seealso{BME_H}
##
## @end deftypefn

##== History
## 2007-10-26
## * add argument p_error

function matrix = BME_V(radius, edgeangle, varargin)
#  p_error = 0;
#  if (length(varargin) > 0)
#    p_error = varargin{1};
#  endif
  [p_error, b] = get_properties(varargin, {"pError", "vedge"}, {0, 0})
  edge_k = (-tan(edgeangle)/radius + b/cos(edgeangle)/6/(radius^2))/(1+p_error);
  
  matrix = [1, 0, 0;
            edge_k, 1, 0;
            0, 0, 1];
endfunction
