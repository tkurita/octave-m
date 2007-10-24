#shareTerm /Users/tkurita/WorkSpace/ÉVÉìÉNÉçÉgÉçÉì/2007.06-7 9MeV ì¸éÀ COD/BMPe2/BMPe2.m
## usage : result = lookup_COD_at_elements(cod_rec, cod_field_name, elem_names)
##            or
##         result = lookup_COD_at_elements(cod_list, lattice, elem_names)
## get COD at center position of the element of which name is elem_names
##
##= Parameters
##  * cod_rec
##      .lattice
##      .(cod_field_name)
##  * cod_field_name -- specify field name in cod_rec to use
##  * elem_names -- a name of the element or cell array of names
##  * cod_list -- x-y matrix of COD
##  * lattice -- a cell array of elements
##
##= Result
## COD [mm] at center position of elem_names
## if elem_names is cell array, result will be a structure.

##== History
## * 2007.09.28
## accept arguments of cod_list and lattice
##
## * 2007.09.05
## elem_names can be cell array. and result is structure
## rename getCODAtElement to lookup_COD_at_elements

#function result = lookup_cod_at_elements(cod_rec, cod_field_name, elem_names)
function result = lookup_cod_at_elements(varargin)
  #varargin = {cod_T030_sum_0, lat_rec_FT.lattice, "BPM7"};
  if isstruct(varargin{1})
    a_lattice = varargin{1}.lattice;
    cod_list = varargin{1}.(varargin{2});
  else
    cod_list = varargin{1};
    a_lattice = varargin{2};
  end
  elem_names = varargin{3};
  
  is_multielems = iscell(elem_names);
  if (!is_multielems)
    elem_names = {elem_names};
  endif
  
  cod_at_elems = [];
  for a_name = elem_names
    center_position = element_with_name(a_lattice, a_name).centerPosition;
    cod_at_elems(end+1) = interp1(cod_list(:,1), cod_list(:,2), center_position, "linear", "extrap");
  endfor
  if is_multielems
    result = struct_fields_values(elem_names, cod_at_elems);
  else
    result = cod_at_elems(1);
  endif
endfunction