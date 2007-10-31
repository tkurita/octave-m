## Usage : s = build_struct (foo,bar, ... ) == struct ("foo",foo,"bar",bar,...)
##
## Groups foo, bar, ... into a struct whose fields are "foo", "bar" ...
## and such that s.foo == foo, s.bar == bar ...  


function s = build_struct(varargin)

for i=1:nargin
   s.(deblank(argn(i,:))) = varargin{i};
end
