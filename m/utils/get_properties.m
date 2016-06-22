## -*- texinfo -*-
## @deftypefn {Function File} {@var{prop_values} =} get_properties(varargin, @var{prop_defvals})
## @deftypefnx {Function File} {@var{prop_values} =} get_properties(varargin, @var{prop_names}, @var{def_values})
##
## Parse cell array of property/values pairs.
## 
## @example
## varargin = @{"prop_a", val_a, "switch_b", "prob_c",..@};
##
## opts = get_properties(varargin,
##                       @{"prop_a"  , def_val_a; ...
##                         "switch_b", boolean  ; ...
##                         "flag_c", def_val_c @})
##
##    or
##
## opts = get_properties(varargin,
##                       @{"prop_a", "switch_b","flag_c", ...@},
##                       @{def_val_a, boolean, def_val_c, ...@})
## @end example
## 
## @strong{Inputs}
## @table @var
## @item params
## cell array. usually varargin
## @item labels
## cell array of names of properties.
## @item def_values
## cell array of default value list.
## If defualt value is boolean, the property can tread as a flag.
## IF the flag property name is in @var{params}, the value will be treatead as true.
## @end table
##
## @strong{Outputs}
## @table @var
## @item prop_values
## If nargout is 1, @var{prop_values} will be a structure of which fields are @var{propnames}.
## If nargout is greater than 1, @var{prp_values} will be a cell array of values.
## @end table
## 
## @seealso{parseparam, inputParser}
## @end deftypefn

function varargout = get_properties(prop_list, varargin)
  if (length(varargin) == 1)
    prop_names = varargin{1}(:,1)';
    default_values = varargin{1}(:,2)';
  else
    prop_names = varargin{1};
    default_values = varargin{2};
  endif
  varargout = default_values;
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
  
  if ((nargout <= 1))
    varargout{1} = struct_fields_values(prop_names, varargout);
  end
end
