## usage : steerer = steererSetting(latRec, name, value)
##
##= Parameters
## * 
function steerer = steererSetting(latRec, name, value)
  steerer = getElementWithName(latRec.lattice, name);
  kickAngle = calcSteerAngle(steerer, value, latRec.brho);
  steerer.kickVector = [0; kickAngle; 0; 0];
  ductMat = DTmat(steerer.len/2);
  steerer.halfDuct = [ductMat(1:2,1:2), zeros(2,2); zeros(2,2), ductMat(1:2,1:2)];
endfunction
