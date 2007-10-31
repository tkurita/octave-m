## Usage : s = struct_fields_values({"foo","bar", ...}, [val1, val2, ...] ) 
##              == struct ("foo",val1,"bar",val2,...)
##

function s = struct_fields_values(field_names, field_values)

for n = 1:length(field_names)
   s.(field_names(n)) = field_values(n);
end
