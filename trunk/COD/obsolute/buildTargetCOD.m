## Usage : targetCOD = buildTargetCOD(codRecord)
##  
##  obsolute use cod_list_with_bpms
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

##== History
## * 2007.10.01
## obsolute

function targetCOD = buildTargetCOD(codRecord)
  warning("buildTargetCOD is obsolete. Use cod_list_with_bpms.");
  
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