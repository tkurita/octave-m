## usage : [codRecord_FB, codRecord_FT] = doublelFitCOD(codRecord_FB, codRecord_FT);
##
##= Parameters
## * codRecord (structure) 
##    .steererNames
##    .horv
##    .lattice
##    .brho
##    .tune
##    [.initialValues]
##= Results
##     .steererValues
##     .pError

#shareTerm ../../../WorkSpace/シンクロトロン/2006.9-12 垂直 COD/Check_PR12_1211/Check_PR12_1211.m

##= Hisotry
## 2013-06-19
## * "weights" field can be a cell array instead of a structure.
## 2008-05-09
## * Used value_for_kickangle instead of calcKickerValue.
## 2007.07.12
## * add useWeight option

function [codRecord_FB, codRecord_FT] = ...
              doublelFitCOD(codRecord_FB, codRecord_FT, variableKickers, varargin);
  #  codRecord_FB = codRec_FB_correct;
  #  codRecord_FT = codRec_correct_FT;
  #  variableKickers = {"QD2"};

  use_kick_factors = false;
  use_weight = false;
  for n = 1:length(varargin)
    if (strcmp(varargin{n}, "useKickFactors"))
      if (isfield(codRecord_FB, "kickFactors"))
        use_kick_factors = true;
      endif
    endif
    
    if (strcmp(varargin{n}, "useWeight"))
      use_weight = true;
    endif
  endfor
  
  codMatStruct_FB = buildCODMatrix(codRecord_FB);
  codMatStruct_FT = buildCODMatrix(codRecord_FT);
  steerer_names = codRecord_FB.steererNames;
  kickers = codMatStruct_FB.kickers;
  
  nrows_FB = rows(codMatStruct_FB.mat);
  nrows_FT = rows(codMatStruct_FT.mat);
  brho_ratio = codRecord_FB.brho/codRecord_FT.brho;
  mat_FB = codMatStruct_FB.mat;
  mat_FT = brho_ratio.*codMatStruct_FT.mat;
  
  if (use_kick_factors)
    kick_factors_FB = [];
    kick_factors_FT = [];
    for n = 1:length(kickers)
      for m = 1:length(steerer_names)
        if (strcmp(kickers{n}.name, steerer_names{m}))
          kick_factors_FB(end+1) = codRecord_FB.kickFactors(m);
          kick_factors_FT(end+1) = codRecord_FT.kickFactors(m);
        endif
      endfor
    endfor
    row_vec = 1./kick_factors_FB;
    row_vec = (row_vec(:))';
    kick_factor_mat_FB = repmat(row_vec, nrows_FB, 1);
    
    row_vec = 1./kick_factors_FT;
    row_vec = (row_vec(:))';
    kick_factor_mat_FT = repmat(row_vec, nrows_FT, 1);
    
    mat_FB = mat_FB.*kick_factor_mat_FB;
    mat_FT = mat_FT.*kick_factor_mat_FT;
  endif
  
  var_kicker_indexes = [];
  for n = 1:length(codMatStruct_FB.kickers)
    for m = 1:length(variableKickers)
      var_kicker = variableKickers{m};
      if (strcmp(codMatStruct_FB.kickers{n}.name, var_kicker))
        var_kicker_indexes(end+1) = n;
      endif
    endfor
  endfor
  
  zero_col_FB = zeros(nrows_FB, 1);
  zero_col_FT = zeros(nrows_FT, 1);
  col_shift = 0;
  for n = var_kicker_indexes
    mat_FB = insertColumn(mat_FB, zero_col_FB, n+1+col_shift);
    mat_FT = insertColumn(mat_FT, zero_col_FT, n+col_shift);
    col_shift++;
  endfor
  
  double_mat = [mat_FB; mat_FT];
  ref_cod = [codMatStruct_FB.refCOD; codMatStruct_FT.refCOD]/1000;
  if (use_weight)
    dy = [];
    dy = [dy; extract_dy(codRecord_FB, codMatStruct_FB)];
    dy = [dy; extract_dy(codRecord_FT, codMatStruct_FT)];
    dy = 1./dy;
    [kick_angles, s] = wsolve(double_mat, ref_cod, dy);
  else
    kick_angles = double_mat \ ref_cod;
  endif
  
  kick_angles_FT = kick_angles;
  kick_angles_FB = kick_angles;
  
  for n = var_kicker_indexes
    kick_angles_FB(n+1) = [];
    kick_angles_FT(n) = [];
  endfor
  kick_angles_FT = kick_angles_FT*brho_ratio;
  
  ##== rearrage kickAngleResult to fit order of steererNames
  kick_angles_sorted_FB = [];
  kick_angles_sorted_FT = [];
  steerer_values_FT = [];
  steerer_values_FB = [];
  for n = 1:length(steerer_names)
    target_name = steerer_names{n};
    for m = 1:length(kickers)
      if (strcmp(target_name, kickers{m}.name))
        kick_angles_sorted_FB(end+1) = kick_angles_FB(m);
        kick_angles_sorted_FT(end+1) = kick_angles_FT(m);
        steerer_values_FB(end+1) = ib_for_kickangle(kickers{m}, 
                            kick_angles_FB(m), codRecord_FB.brho);
        steerer_values_FT(end+1) = ib_for_kickangle(kickers{m}, 
                            kick_angles_FT(m), codRecord_FT.brho);
      endif
    endfor
  endfor
  
  if (use_kick_factors)
    kick_angles_sorted_FB = kick_angles_sorted_FB./codRecord_FB.kickFactors;
    kick_angles_sorted_FT = kick_angles_sorted_FT./codRecord_FT.kickFactors;
  endif
  
  codRecord_FB.kickAngles = kick_angles_sorted_FB;
  codRecord_FB.steererValues = steerer_values_FB;
  codRecord_FT.kickAngles = kick_angles_sorted_FT;
  codRecord_FT.steererValues = steerer_values_FT;
  
#  codRecord_FB.correctCOD = calcCODWithPerror(codRecord_FB);
#  codRecord_FT.correctCOD = calcCODWithPerror(codRecord_FT);
#  xyplot(codRecord_FB.targetCOD, "-@"\
#    , codRecord_FB.correctCOD, "-"\
#    , codRecord_FT.targetCOD, "-@"\
#    , codRecord_FT.correctCOD, "-")
endfunction

function dy = extract_dy(cod_rec, cod_mat_struct)
  if (isfield(cod_rec, "weights"))
    dy = [];
    weights = cod_rec.weights;
    if iscell(weights)
      weights = struct(weights{:});
    endif
    for a_name = cod_mat_struct.monitors
      if (isfield(weights, a_name{1}))
        dy = [dy; weights.(a_name{1})];
      else
        dy = [dy; 1];
      end
    endfor
  else
    dy = ones(length(cod_mat_struct.monitors),1);
  endif
end
