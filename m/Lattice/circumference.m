## usage: c = circumference(all_elements)
##
## 周長を計算する

##==History
## 2007-10-12
## * accept lat_rec structure
## * rename cuntourLength to circumference 

function c = circumference(all_elements)
  if (isstruct(all_elements))
    all_elements = all_elements.lattice;
  endif
  
  c = 0;
  for n = 1:length(all_elements)
    c += all_elements{n}.len;
  endfor
endfunction