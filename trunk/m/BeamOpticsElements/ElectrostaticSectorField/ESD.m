function esd_struct = ESD(prop, a_name, varargin)
  len = prop.radius*prop.angle;
  esd_struct = setfields(prop, "len", len, "name", a_name, "kind", "ESD");  
  
  esd_struct.mat.h = ESCylindrical_mat(esd_struct);
  esd_struct.mat.v = DTmat(len);
  
  if (length(varargin) > 0)
    if (ismatrix(varargin))
      esd_struct.duct = varargin{n};
    endif
  endif
endfunction