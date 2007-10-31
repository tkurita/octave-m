## -*- texinfo -*-
## @deftypefn {Function File} {} join_struct(@var{struct1}, @var{struct2})
## 
## Merge every fields of @var{struct2} in to @var{struct1}.
## 
## @end deftypefn

##== History
## 2007-10-25
## * renamed from joinStruct

function struct1 = join_struct(struct1, struct2)
  for [val, key] = struct2
    struct1.(key) = val;
  endfor
endfunction
