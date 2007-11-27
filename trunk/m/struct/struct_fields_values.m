## -*- texinfo -*-
## @deftypefn {Function File} {} struct_fields_values(fieldnames, values)
##
## Make a structure with a list of field names and associated values.
##
## @end deftypefn

function s = struct_fields_values(names, fieldvalues)
  if (ismatrix(fieldvalues))
    fieldvalues = mat2cell(fieldvalues...
      , columns(fieldvalues), ones(1, rows(fieldvalues)));
  end
  
  for n = 1:length(names)
     s.(names(n)) = fieldvalues{n};
  end
end