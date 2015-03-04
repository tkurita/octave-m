## -*- texinfo -*-
## @deftypefn {Function File} {@var{result} =} position_for_element(@var{course}, @var{name})
##
## Rerurn entrance position for the element in the course
## @end deftypefn

##== History
## 2008-06-23
## * first implementation

function retval = position_for_element(course, name)
  retval = 0;
  for n = 1:length(course)
    if (isfield(course{n}, "name"))
      if (strcmp(course{n}.name, name))
        break;
      endif
      retval += course{n}.len;
    endif
  endfor
endfunction