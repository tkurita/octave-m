## usage : plotarg = tuneDiagram(nxrange, nyrange, maxResoOrder)
##
## = Parameters
##
## = Result
## plotarg is a cell array for the argument of plot function

## = Hstory
## == 2006.10.05
## initial implementation

function plotarg = tuneDiagram(nxrange, nyrange, maxResoOrder)
  plotarg = {};
  #maxResoOerder = 3
  for resoOrder = 1:maxResoOrder
    #resoOrder = 4
    coeffs = [0:resoOrder; resoOrder:-1:0];
    ##== no coupling
    switch (resoOrder)
      case (1)
        targetCoeffs = coeffs;
      otherwise
        targetCoeffs = [coeffs(:,1), coeffs(:,end)];
    endswitch
    
    newargs = plotArgumentForCoeff(targetCoeffs, nxrange, nyrange);
    plotarg = [plotarg, newargs];
    
    if (resoOrder > 1)
      ##== sum
      targetCoeffs = coeffs(:,2:end-1);
      newargs = plotArgumentForCoeff(targetCoeffs, nxrange, nyrange);
      plotarg = [plotarg, newargs];
      
      ##== diff
      targetCoeffs(2,:) = -1 * targetCoeffs(2,:);
      newargs = plotArgumentForCoeff(targetCoeffs, nxrange, nyrange);
      plotarg = [plotarg, newargs];
    endif
  endfor
endfunction
