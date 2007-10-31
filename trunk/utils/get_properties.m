## Usage :
##  [val1, val2, ...] = get_properties({"prop_a", val_a,..},
##                                      {"prop_a",...},
##                                      {def_val_a,...})
##

function varargout = get_properties(prop_list, prop_names, default_values)
  n_prop = length(prop_names);
  varargout = default_values;
  for n = 1:2:length(prop_list)
    a_name = prop_list{n};
    a_value = prop_list{n+1};
    for m = 1:n_prop
      if strcmp(a_name, prop_names{m})
        varargout{m} = a_value;
      endif
      
    end
    
  end
endfunction
