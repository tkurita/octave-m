## Usage : targetCOD = buildTargetCOD(codRecord)
##
## BPM の名前を key とした COD のデータ codRecord.codAtBPM（structure）より、
## 位置とCODのリストに変換する。
##
## = Parameter
## * codRecord (structure)
##      .codAtBPM -- data structure of COD at BPM [mm]
##                   field name give element name and the value is COD
##      .lattice -- output of calcLattice and it's family functions
## = Results
## * targetCOD -- (:,1) postion of BPM
##                (:,2) COD given by the parameter codAtBPM

function targetCOD = buildTargetCOD(codRecord)
  x = []; # COD
  s = []; # position
  for n = 1:length(codRecord.lattice)
    latticeElement = codRecord.lattice{n};
    elementName = latticeElement.name;
    if (isfield(codRecord.codAtBPM, elementName))
      x = [x; codRecord.codAtBPM.(elementName)];
      s = [s; latticeElement.centerPosition];
    endif
  endfor
  targetCOD = [s,x];
endfunction