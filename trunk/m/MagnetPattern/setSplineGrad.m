## usage: target_span = setSplineGrad(target_span, pre_span, post_span)
## 
##  post_span is optional.
##  If post_span is ommited, gradient of end of span is assumed 0.
##

function target_span = setSplineGrad(varargin)
  target_span = varargin{1};
  pre_span = varargin{2};
  if (length(varargin) > 2)
    endGrad = varargin{3}.grad(1);
  else
    endGrad = 0;  
  endif

  target_span.grad = [pre_span.grad(end),endGrad];
end