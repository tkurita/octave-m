## -*- texinfo -*-
## @deftypefn {Function File} {} file_exists(@var{path})
##
## Check whether @var{path} exists or not.
## 
## @end deftypefn

##== History
## 2008-05-16
## * first implementation.

function retval = file_exists(path)
  retval = !isempty(stat(path));
endfunction