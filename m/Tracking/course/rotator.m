function result = rotator(rotate_prop)
  result = setfields(rotate_prop, "apply", @shift_particles...
                                , "kind", "Rotator"...
                                , "len", 0);
  result.vector = [0; rotate_prop.h; 0; 0; rotate_prop.v; 0];
end