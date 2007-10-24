## usage : out_cod_list = shift_cod_with_perror(in_cod_list, inStruct)
##            or
##         out_cod_list = shift_cod_with_perror(in_cod_list, lattice, p_error)
##
##= Parameters
## * in_cod_list -- [position; COD at position]
## * inStruct
##    .lattice
##    .pError
##    .horv
## * lattice -- a cell array of elements
## * p_error -- momenum error, dP/P
##
##= Result
## * out_cod_list -- [position; COD shifted with dispersion and pError]

##= History
## * 2007.09.28
## accept arguments of lattice and p_errir
## rename from "shiftCODWihtPerror"

#function out_cod_list = shift_cod_with_perror(in_cod_list, inStruct)
function out_cod_list = shift_cod_with_perror(varargin)
  in_cod_list = varargin{1};
  if nargin > 2
    a_lattice = varargin{2};
    p_error = varargin{3};
  else
    a_lattice = varargin{2}.lattice;
    p_error = varargin{2}.pError;
  end
  
  positionList = [];
  dispersionList = [];
  
  for m = 1:length(a_lattice)
    currentElement = a_lattice{m};
    positionList = [positionList;
    currentElement.centerPosition; currentElement.exitPosition];
    
    dispersionList = [dispersionList;
    currentElement.centerDispersion; currentElement.exitDispersion];
  endfor
  
  diffCODList = dispersionList*p_error*1000;
  y = interp1(positionList, diffCODList, in_cod_list(:,1), "linear", "extrap");
  out_cod_list = [in_cod_list(:,1), in_cod_list(:,2) + y];
endfunction

    