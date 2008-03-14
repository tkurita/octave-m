## -*- texinfo -*-
## @deftypefn {Function File} {} is_in_parallerogram(@var{para_acceptance}, @var{xy_point}, @var{horv})
##
## Check whether @var{xy_point} is in the acceptance of @var{para_acceptance}
##
## @end deftypefn


##== History
## 2008-03-13
## * first implementaion

#shareTerm /Users/tkurita/WorkSpace/シンクロトロン/2008.01 Tracking/extraction/extraction.m
function result = is_in_parallerogram(a_para, xy_point, horv)
  switch horv
    case "h"
      xory = "x";
    case "v"
      xory = "y";
  endswitch
  
  if(! ((xy_point(1) > a_para.([xory,"min"])) & (xy_point(1) < a_para.([xory,"max"]))))
    #"not in xrange"
    result = false;
    return;
  end
  
  xl = interp1([a_para.([xory,"min"]), a_para.([xory,"max"])]...
    , [a_para.([xory,"dash_min"]).l, a_para.([xory,"dash_max"]).l]...
    , xy_point(1), "linear");
  
  if (xy_point(2) <= xl)
    #"xdash is too small"
    result = false;
    return;
  end
  
  xh = interp1([a_para.([xory,"min"]), a_para.([xory,"max"])]...
    , [a_para.([xory,"dash_min"]).h, a_para.([xory,"dash_max"]).h]...
    , xy_point(1), "linear");
  
  if (xy_point(2) >= xh)
    #"xdash is too large"
    result = false;
    return;
  end
  
  result = true;
end
