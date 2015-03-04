## -*- texinfo -*-
## @deftypefn {Function File} {@var{retval} =} kicker_values_vs_positions(@var{arg})
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
## 2014-07-09
## * first implemention

function retval = kicker_values_vs_positions(cod_obj, varargin)
  if ! nargin
    print_usage();
  endif
  
  kicker_names = cod_obj.kickers;
  kicker_values = cod_obj.kick_angles;
  a_lattice = cod_obj.ring.lattice;
  retval = [];
  for n = 1:length(a_lattice)
    elem = a_lattice{n};
    ind = find(strcmp(elem.name, kicker_names));
    if ind
      retval(end+1,:) = [elem.centerPosition, kicker_values(ind(1))];
    endif
  endfor
endfunction

%!test
%! func_name(x)
