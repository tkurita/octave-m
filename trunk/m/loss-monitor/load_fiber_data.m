## -*- texinfo -*-
## @deftypefn {Function File} {@var{result} =} func_name(@var{arg})
##
## @end deftypefn

##== History
##

function retval = load_fiber_data(fname)
  source(fname);
  a_mat = to_mat(ans);
  retval = aggregate_array(a_mat, 21);
endfunction

function retval = to_mat(wire_data)
  wire_mat = zeros(length(wire_data), 2);
  for n = 1:length(wire_data)
    wire_mat(n,1) = wire_data{n}{1};
    wire_mat(n,2) = wire_data{n}{2};
    if (wire_mat(n,2) < 1) && (wire_mat(n,2) > 0)
      wire_mat(n,2) = 0;
    end
  end
  wire_mat(1,2) = 0;
  retval = wire_mat(1:2500,:);
endfunction