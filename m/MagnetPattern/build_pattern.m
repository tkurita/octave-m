## -*- texinfo -*-
## @deftypefn {Function File} {@var{result} =} build_pattern(@var{pattern_cells})
##
## @example
## pattern_cells = {...
## 607.1, 1.6473, "spline";
## 632.1, 1.6968, "";
## 657.1, 1.7067, "end"};
## build_pattern(pattern_cells)
## @end example
## The lenght of the value of third column of last row must be greater than 0 
## to indicate end of span.
##
## @seealso{span_with_cells}
## @end deftypefn

function span_struct_list = build_pattern(pattern_cells)
  beg_span = 1;
  span_list = {};
  for n = 2:rows(pattern_cells)
    span_flag = pattern_cells{n,3};
    if (length(span_flag) > 0)
      a_span = pattern_cells(beg_span:n, :);
      span_list{end+1} = a_span;
      beg_span = n;
    endif
  endfor

  span_struct_list = {};
  for n = 1:length(span_list)
      span_struct_list{n} = span_with_cells(span_list{n});
  endfor
  
  n_span = length(span_struct_list);
  for n = 2:n_span
    if strcmp(span_struct_list{n}.funcType, "spline")
      span_set = {span_struct_list{n}, span_struct_list{n-1}};
      if (n < n_span) && strcmp(span_struct_list{n+1}.funcType, "linear")
        span_set{end+1} = span_struct_list{n+1};
      endif
      span_struct_list{n} = setSplineGrad(span_set{:});  
    endif
  endfor

endfunction

%!test
%! pattern_cells = ...
%! {\
%! 607.1, 1.6473, "spline";
%! 632.1, 1.6968, "";
%! 657.1, 1.7067, 0};
%! build_pattern(pattern_cells)


%test
%! pattern_cells = ...
%! {\
%! 0    , 0.3473, "linear";
%! 35   , 0.3473, "spline";
%! 60   , 0.3572, "";
%! 85   , 0.4067, "linear";
%! 607.1, 1.6473, "spline";
%! 632.1, 1.6968, "";
%! 657.1, 1.7067, 0};
%! build_pattern(pattern_cells)
