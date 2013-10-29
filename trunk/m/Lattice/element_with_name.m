## Usage : element_with_name(all_elements, a_name)
##            or
##         element_with_name(lat_rec, a_name)
##            or
##         elemnt_with_name(all_elments or lat_rec, a_name or names)
##            or
##         element_with_name(all_elements, "pattern", {"p1", "p2",...})
## 
## all_elements is cell array which elements are data structures.
## find an element of all_elements whose name field matches a_name.
##
##== Parameters
## * all_elements : cell array of elements
## * a_name : name of a element to pick up
## * lat_rec : a structure which have a field .lattice
## * names : a cell array of names of elements to pick up
##
##== Result
## If second argument (a_name or names) is a cell array, 
## result is a cell array of elements

##== History
## 2013-10-29
## * the order of returned elements will follows the source "all_elememnts".
## * call print_usage if no arguments are given.
## * names is allowed to be regular expressions.
##
## 2007-11-27
## * avoid error when no name field elements are inclued in all_elements
##
## 2007-11-01
## * If nargout > 1, indexes of elements are returned.
##
## 2007-10-11
## * accept names
##
## 2007-10-02
## * accept lat_rec

function varargout = element_with_name(all_elements, varargin)
  if ! nargin
    print_usage();
  endif

  if (isstruct(all_elements))
    all_elements = all_elements.lattice;
  endif
  
  cell_out = true;
  use_regexp = false;
  switch length(varargin)
    case 1
      names = varargin{1};
      match_name = @(target, name) strcmp(target, name);
    case 2
      names = varargin{2};
      match_name = @(target, pattern) regexp(target, pattern);
      use_regexp = true;
    otherwise
      print_usage();
      error("Invalid number of arguments.");
  endswitch
  
  if (ischar(names))
    names = {names};
    cell_out = false;
  endif
  
  output = {};
  ind_elem = [];
  for n = 1:length(all_elements)
    an_elem = all_elements{n};
    for k = 1:length(names)
      a_name = names{k};
      if isfield(an_elem, "name") && match_name(an_elem.name, a_name)
        output{end+1} = an_elem;
        ind_elem(end+1) = n;
      endif
    endfor
  endfor

#  for k = 1:length(names)
#    a_name = names{k};
#    for n = 1:length(all_elements)
#      if (isfield(all_elements{n}, "name") && match_name(all_elements{n}.name, a_name))
#        output{end+1} = all_elements{n};
#        ind_elem(end+1) = n;
#      endif
#    endfor
#  endfor
  
  if (isempty(output))
    error("Can't find elements for the name '%s'", names{1});
  endif
  if (!cell_out)
    output = output{1};
    ind_elem = ind_elem(1);
  endif
  varargout{1} = output;
  if (nargout > 1)
    varargout{2} = ind_elem;
  endif
endfunction

%!test
%! element_with_name({},{}) % check syntax
