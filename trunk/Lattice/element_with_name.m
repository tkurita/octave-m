## Usage : element_with_name(all_elements, a_name)
##            or
##         element_with_name(lat_rec, a_name)
## 
## all_elements is cell array which elements are data structures.
## find an element of all_elements whose name field matches a_name.
##
##== Parameters
## * all_elements : cell array of elements
## * a_name : name of a element to pick up
## * lat_rec : a structure which have a field .lattice

##== History
## 2007.10.02
## * accept lat_rec

function target_element = element_with_name(all_elements, a_name)
  if (isstruct(all_elements))
    all_elements = all_elements.lattice;
  endif
  
  for n = 1:length(all_elements)
    if (strcmp (all_elements{n}.name, a_name))
      target_element = all_elements{n};
      break;
    endif
  endfor
endfunction