## usage : result = lookup_COD_at_elements(cod_rec, cod_field_name, elem_names)
##
## get COD at center position of the element of which name is elem_names
##
##= Parameters
##  * cod_rec
##      .lattice
##      .(cod_field_name)
##  * cod_field_name -- specify field name in cod_rec to use
##  * elem_namess -- name of the element or cell array of 
##
##= Result
## COD [mm] at center position of elem_names
## if elem_names is cell array, result will be structure.

##== History
## * 2007.09.05
## elem_names can be cell array. and result is structure
## rename getCODAtElement to lookup_COD_at_elements

function result = lookup_COD_at_elements(cod_rec, cod_field_name, elem_names)
  is_multielems = iscell(elem_names);
  if (!is_multielems)
    elem_names = {elem_names};
  endif
  
  cod_at_elems = [];
  for a_name = elemNae
    centerPosition = getElementWithName(cod_rec.lattice, a_name).centerPosition;
    codList = cod_rec.(cod_field_name);
    cod_at_elems(end) = interp1(codList(:,1), codList(:,2), centerPosition, "linear", "extrap");
  endfor
  
  if is_multielems
    result = struct_fields_values(elem_names, cod_at_elems);
  else
    result = cod_at_elems(1);
  endif
  
endfunction