function result = shifter(offset_prop)
  result = setfields(offset, "apply", @add_vector, "kind", "Shifter");
  result.vector = [offset_prop.h; 0; 0; offset_prop.v; 0; 0];
endfunction