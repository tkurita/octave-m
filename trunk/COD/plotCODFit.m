## usage plotCODFit(cod_recrod1, cod_record2 ...)
##
## compare a measured COD and correctable COD (fitting result).
## cod_records in arguments must have following fields
## .targetCOD
## .correctCOD

function plotCODFit(varargin)
  plotInput = {};
  for i = 1:length(varargin)
    theCODRec = varargin{i};
    if (isfield(theCODRec, "time"))
      plot_option = sprintf("@;measured COD at %i msec;", theCODRec.time);
    else
      plot_option = "@;measured COD;";
    endif
    
    plot_comment = "result of least mean squre fit";
    
    if (isfield(theCODRec, "comment"))
      plot_comment = theCODRec.comment;
    endif
    plotInput = {plotInput{:} ...
      , theCODRec.targetCOD(:,1), theCODRec.targetCOD(:,2), plot_option...
      , theCODRec.correctCOD(:,1), theCODRec.correctCOD(:,2)...
      , [";" plot_comment ";"] } ;
  endfor
  
  plot(plotInput{:});
endfunction