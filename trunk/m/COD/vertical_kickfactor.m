#shareTerm /Users/tkurita/WorkSpace/シンクロトロン/2007.06 9MeV 入射/垂直 COD2/Vertical_COD2.m

## usage :
##  kick_factor
##  [cod_diff_FB, doc_diff_FT]
##  [cod_diff_FB, doc_diff_FT, kick_factor]  
##    = vertical_kickfactor(codRecord_FB, codRecord_FT, codAtBPM_FB, codAtBPM_FT);
##
##  Evaluate scaling factor(kick_factor) to represent COD corrected 
##  by setting of codRecord_FB and codRecord_FT.
##  codRecord_FB and codRecordFT should be results of doubldlFitCOD.
##  
##  If no output arguments, print kick_factor and 
##  steerer setting values scaled by kick_factor
##
##= Parameters
## * codRecord_FB (structure) 
## * codRecord_FT (structure)
## * codAtBPM_FB : COD correction result by codRecord_FB
## * codAtBPM_FT : COD correction result by codRecord_FT
##
##= Results
## * kick_factor
## * cod_diff_FB : steererValues field is codRecord_FB.steererValues/kick_factor
## * cod_diff_FT

##= Hisotry
## 2007-12-03
## * update obsolete functions
##
## 2007.07.12
## * add useWeight option

function varargout\
              = vertical_kickfactor(codRecord_FB, codRecord_FT, codAtBPM_FB, codAtBPM_FT);
  #  codRecord_FB = cod_rec_FB_3;
  #  codRecord_FT = cod_rec_FT_3;
  #  codAtBPM_FB = codAtBPM_after_FB_3
  #  codAtBPM_FT = codAtBPM_after_FT_3
  cod_diff_FB = codRecord_FB;
  cod_diff_FT = codRecord_FT;
  cod_diff_FB.codAtBPM = subtract_cod(codRecord_FB.codAtBPM, codAtBPM_FB);
  cod_diff_FT.codAtBPM = subtract_cod(codRecord_FT.codAtBPM, codAtBPM_FT);
  codMatStruct_FB = buildCODMatrix(cod_diff_FB);
  codMatStruct_FT = buildCODMatrix(cod_diff_FT);
  codList_FB = applyKickerAngle(codMatStruct_FB, cod_diff_FB);
  codList_FT = applyKickerAngle(codMatStruct_FT, cod_diff_FT);
  ref_cod = [codMatStruct_FB.refCOD; codMatStruct_FT.refCOD]/1000;
  kick_factor = [codList_FB; codList_FT]\ref_cod;
  cod_diff_FB.kickFactor = kick_factor;
  cod_diff_FT.kickFactor = kick_factor;
  cod_diff_FB.steererValues = cod_diff_FB.steererValues/kick_factor;
  cod_diff_FT.steererValues = cod_diff_FT.steererValues/kick_factor;
  
  switch nargout
    case  0
      kick_factor
      printf("At Flat Base\n");
      printKickerValues(cod_diff_FB);
      printf("At Flat Top\n");
      printKickerValues(cod_diff_FT);  
      
    case  1
      varargout = {kick_factor};
    case 2
      varargout = {cod_diff_FB, cod_diff_FT};
    case 3
      varargout = {cod_diff_FB, cod_diff_FT, kick_factor};
    otherwise
      error("Number of output arguments must be less than or equal to 3");
  endswitch
  
end
