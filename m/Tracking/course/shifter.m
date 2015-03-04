function result = shifter(offset_prop, varargin)
  if (length(varargin) > 0)
    if (strcmp(varargin{1}, "axis"))
      applyer = @add_vector;
    else
      applyer = @shift_particles;
    end
  else
    applyer = @shift_particles;
  end
  result = setfields(offset_prop, "apply", applyer...
                                , "kind", "Shifter"...
                                , "len", 0);
  result.vector = [offset_prop.h; 0; 0; offset_prop.v; 0; 0];
endfunction