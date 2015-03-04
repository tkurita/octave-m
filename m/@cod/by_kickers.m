## -*- texinfo -*-
## @deftypefn {Function File} {@var{retval} =} by_kickers(@var{cod})
## description
## @strong{Inputs}
## @table @var
## @item arg1
## description of @var{arg}
## @end table
##
## @strong{Outputs}
## @table @var
## @item retval
## description of @var{retval}
## @end table
##
## @end deftypefn

##== History
## 2013-11-27
## * ported from cod_list_with_kickers

function cod_list = by_kickers(cod_obj, varargin)
  if ! nargin
    print_usage();
  endif
  
  cod_mat = build_matrix(cod_obj, "full");
  use_kickfactor = true;
  use_steerer_values = false;
  if (length(varargin) > 0) 
    for n = 1:length(varargin)
      if strcmp(varargin{n}, "useSteererValues")
        use_steerer_valuse = true;      
      else
        warning([varargin{n}, " is unknown option\n"]);
      endif
    endfor
  else
    varargin = {};
  endif
  
  if (use_steerer_values )
    if (isfield(cod_obj, "steererValues") )
      varargin{end+1} = "useSteererValues";
    else
      error("cod_obj don't have steererValues field.");
    endif
  endif
  
  cod_list = apply_kick_angles(cod_obj, cod_mat, varargin{:});
  
  if (strcmp(cod_obj.horv,"h"))
    cod_list = cod_list + cod_mat.dispersion*cod_obj.pError;
  endif
  cod_list = cod_list*1000;
  positionList = cod_mat.positions;
  if (isfield(cod_obj, "range"))
    begPos = cod_obj.range(1);
    endPos = cod_obj.range(2);
    
    for i = 1 : length(positionList)
      if ((positionList(i) <= begPos) || (endPos <= positionList(i)))
        cod_list(i) = 0;
      endif
    endfor
    
  endif
  
  cod_list = [positionList, cod_list];
endfunction

%!test
%! func_name(x)
