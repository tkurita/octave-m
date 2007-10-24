## usage : cod_rec = lFitCODWithFactor(cod_rec, ["useSteererValues"]);
##
## fit COD with factor and momemtum error.
##
##== Parameters
## * cod_rec (structure) 
##   - .steererNames
##   - .horv
##   - .lattice
##   - .tune
##   - .kickAngles or .steererValues
##   
##== Results
## following fields are appended.
##   - .pError
##   - .kickFactor

##== History
## 
##

function cod_rec = lFitCODWithFactor(cod_rec, varargin);
  if (isfield(cod_rec, "kickFactor"))
    cod_rec = rmfield(cod_rec, "kickFactor");
  endif
  
  if (length(varargin) > 0)
    for n = 1:length(varargin)
      if (strcmp(varargin{n}, "useSteererValues"))
        cod_rec = steerer_valus_to_kick_angles(cod_rec);
      end
    end
  end
  
  codMatStruct = buildCODMatrix(cod_rec);
  codList = applyKickerAngle(codMatStruct, cod_rec);
 
  switch (cod_rec.horv)
    case "h"
      X = [codList, codMatStruct.dispersion];
    case "v"
      X = codList;
    otherwise
      error("cod_rec.horv must be \"h\" or \"v\"");
  endswitch
  
  refCODList = codMatStruct.refCOD/1000; # convert unit from [mm] to [m]
  kickFactorResult = X \ refCODList;
  
  switch (cod_rec.horv)
    case "h"
      cod_rec.kickFactor = kickFactorResult(1);
      cod_rec.pError = kickFactorResult(end);
    case "v"
      cod_rec.kickFactor = kickFactorResult;
      cod_rec.pError = 0;
    otherwise
      error("cod_rec.horv must be \"h\" or \"v\"");
  endswitch
  
endfunction

function cod_rec = steerer_valus_to_kick_angles(cod_rec)
  cod_rec.kickAngles = [];
  for n = 1:length(cod_rec.steererNames)
    target_element = element_with_name(cod_rec.lattice, cod_rec.steererNames{n});
    cod_rec.kickAngles(end+1) = ...
    calcSteerAngle(target_element, cod_rec.steererValues(n), cod_rec.brho);
  end
end



  