## -*- texinfo -*-
## @deftypefn {Function File} {[@var{kickers}, @var{currents}] =} disp_currents(@var{cod_obj})
## @deftypefnx {Function File} {@var{currents} =} disp_currents(@var{cod_obj})
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
## 2013-12-13
## * first implementation

function varargout = disp_currents(cod_obj)
  if ! nargin
    print_usage();
  endif
  
  brho = cod_obj.ring.brho;
  itobl_def = itobl_definition();
  current_list = [];
  name_list = {};
  for n = 1:length(cod_obj.kickers);
    name = cod_obj.kickers{n};
    elem = element_with_name(cod_obj.ring, name);
    ka = cod_obj.kick_angles(n);
    itobl = itobl_def(elem);
    current = ka*(brho/itobl);
    printf(["%s : %f [A]\n"] ,name, current);
    current_list(end+1) = current;
    name_list{end+1} = name;
  endfor
  switch nargout
    case 1
      varargout = {current_list};
    case 2
      varargout = {name_list, current_list};
  endswitch
endfunction

%!test
%! disp_current(x)