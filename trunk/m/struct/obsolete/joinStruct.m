function struct1 = joinStruct(struct1, struct2)
  for [val, key] = struct2
    struct1.(key) = val;
  endfor
endfunction
