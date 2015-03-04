## -*- texinfo -*-
## @deftypefn {Function File} {} join_struct(@var{struct1}, @var{struct2})
## 
## Merge every fields of @var{struct2} in to @var{struct1}.
## 
## @end deftypefn

##== History
## 2014-10-02
## * Fixed : a structure as a second argument is not accepted.
## 2012-07-14
## * accept "key1", val1, "key2", val2, ...
## 2007-10-25
## * renamed from joinStruct

function struct1 = join_struct(struct1, varargin)
  if ! nargin
    print_usage();
    return;
  endif
  
  switch length(varargin)
    case 0
      error("Wrong argument numbers");
    case 1
      for [val, key] = varargin{1}
        struct1.(key) = val;
      endfor
    otherwise
      for n = 1:2:length(varargin)
        struct1.(varargin{n}) = varargin{n+1};
      endfor
  endswitch
endfunction
