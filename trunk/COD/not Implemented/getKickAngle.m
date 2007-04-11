##
##= Parameters
## * getting kick angle
##      * currentElement
##      * index of value
##      * brho
## * setting values
##      * kick angles or steerer values
##      * is kick angle or not
function kickAngle = getKickAngle(varargin)
  persistent valueList;
  persistent isKickAngles;
  
  nvarin = length(varargin)
  switch (nvarin)
    case (2)
      valueList = varargin{1};
      isKickAngles = varargin{2};
      return
    case (3)
      currentElement = varargin{1};
      theValue = varargin{2};
      brho = varargin{3};
      
      kickAngle = kickAngleCore(varargin{:});
    otherwise
      error("number of arguments is invalid:%i",nvarin):
  endswitch
  
 
  