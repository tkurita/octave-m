## usage: targetRegion = setSplineGrad(targetRetion, preRegion, postRegion)
## postRegion is optional
## 
function targetRegion = setSplineGrad(varargin)
  targetRegion = varargin{1};
  preRegion = varargin{2};
  if (length(varargin) > 2)
	endGrad = varargin{3}.grad(1);
  else
	endGrad = 0;  
  endif

  targetRegion.grad = [preRegion.grad(end),endGrad];
end