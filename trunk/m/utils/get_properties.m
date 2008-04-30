## Usage :
##  [val1, val2, ...] = get_properties({"prop_a", val_a,..},
##                                      {"prop_a",...},
##                                      {def_val_a,...})
##

##== History
## 2008-04-12
## prop_list が property 名一つだけの時、無限 loop になる不具合を修正
## 
## 2008-04-10
## * property name が指定されているだけの property にも対応した
## * その property が存在していれば true

function varargout = get_properties(prop_list, prop_names, default_values)
  varargout = default_values;

#  n_prop = length(prop_names)
#  for n = 1:2:length(prop_list)
#    a_name = prop_list{n};
#    a_value = prop_list{n+1};
#    for m = 1:n_prop
#      if strcmp(a_name, prop_names{m})
#        varargout{m} = a_value;
#      end
#    end
#  end
  n_args = length(prop_list);        
  n = 1;
  end_arg = false;
  while (n <= n_args)
    a_name = prop_list{n++};
    if (n <= n_args)
      a_value = prop_list{n++};
    else
      a_value = a_name;
      end_arg = true;
    end
    if (ischar(a_value))
      ind = contain_str(prop_names, a_value);
      if (ind)
        a_value = true;
        if (!end_arg)
          n--;
        end
      end
    end
    ind = contain_str(prop_names, a_name);
    if (ind)
      varargout{ind} = a_value;
    end
  end
  
  if (nargout <= 1)
    varargout{1} = struct_fields_values(prop_names, varargout);
  end
end
