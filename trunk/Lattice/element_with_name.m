## Usage : element_with_name(all_elements, a_name)
##            or
##         element_with_name(lat_rec, a_name)
##            or
##         ellemnt_with_name(all_elments or lat_rec, a_name or names)
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
## 2007-10-11
## * accept names
##
## 2007-10-02
## * accept lat_rec

function output = element_with_name(all_elements, names)
  if (isstruct(all_elements))
    all_elements = all_elements.lattice;
  endif
  
  cell_out = true;
  if (ischar(names))
    names = {names};
    cell_out = false;
  endif
  
  output = {};
  for k = 1:length(names)
    a_name = names{k};
    for n = 1:length(all_elements)
      if (strcmp (all_elements{n}.name, a_name))
        output{end+1} = all_elements{n};
        break;
      endif
    endfor
  endfor
  
  if (!cell_out)
    output = output{1};
  endif
  
endfunction

%!test
%! element_with_name({},{}) % check syntax
