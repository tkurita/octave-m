## -*- texinfo -*-
## @deftypefn {Function File} {} struct_fields_values(fieldnames, values)
##
## Make a structure with a list of field names and associated values.
##
## @strong{Inputs}
## @table @var
## @item fieldnames
## a cell array of field names
## @item values
## a cell array or matrix
## @end table
## 
## @strong{Outputs}
## a structure
## @end deftypefn

## 2014-11-04
## * fixed an error on 3.8.2.

function s = struct_fields_values(names, fieldvalues)
  if (ismatrix(fieldvalues))
    fieldvalues = mat2cell(fieldvalues...
      , columns(fieldvalues), ones(1, rows(fieldvalues)));
  end
  
  for n = 1:length(names)
     s.(names{n}) = fieldvalues{n};
  end
end