function result = kickier_simple(kicker_prop)
  result = setfields(offset, "apply", @add_vector, "kind", "Kicker");
  result.vector = [0; kicker_prop.h; 0; 0; kicker_prop.v; 0];
endfunction