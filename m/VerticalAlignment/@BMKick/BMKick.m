function obj = BMKick(lvtable)
  % obj = BMKick(LevelTableBM)
  %     evaluate kick angles
  % fields :
  % * dyds
  %    - skew_total
  %    - tilt
  %    - pitch
  %    - inedge
  %    - outedge
  % * names
  % * indegenames
  % * outedgenames

  if ! nargin
    print_usage();
    return;
  endif
  
  l = 689.5; # 基準点間の距離
  phi = pi/4;
  level_values = lvtable.data;
  if columns(level_values) > 2
    z2 = level_values(:,2) - level_values(:,1);
    z3 = level_values(:,3) - level_values(:,1);
    bmangle = (45/360)*2*pi;
    efflen = 1.57395;
    edgeangle = 1.5*pi/180;
    radius = efflen/bmangle;
    edge_mat = BME_V(radius, edgeangle);
    dyds.inedge = _kick_with_BMQ_shift(edge_mat, level_values(:,1));
    dyds.outedge = _kick_with_BMQ_shift(edge_mat, level_values(:,3));
  else
    z2 = level_values(:,1);
    z3 = level_values(:,2);
  end
  tan_p = z2/l;
  z3d = z3 - l*(1+cos(phi))*tan_p;
  tan_t = (z2 - z3d)/(l*sin(phi));

  sin_t = tan_t./sqrt(1 + tan_t.^2);
  sin_p = tan_p./sqrt(1 + tan_p.^2);
  cos_t = 1./sqrt(1 + tan_t.^2);
  dyds.skew_total = - (sin_t.*sin(phi) + cos_t.*sin_p.*(1-cos(phi)));
  dyds.tilt = - sin_t.*sin(phi);
  dyds.pitch = - sin_p.*(1-cos(phi));
  dyds.tan_pitch = tan_p;
  dyds.tan_tilt = tan_t;
  names = lvtable.names;
  inedgenames = {};
  outedgenames = {};
  for a_name = names'
    inedgenames{end+1, 1} = [a_name{1},"INEDGE"];
    outedgenames{end+1, 1} = [a_name{1}, "OUTEDGE"];
  end
  obj = tars(dyds, names, inedgenames, outedgenames);
  obj = class(obj, "BMKick");
end

function ka = _kick_with_BMQ_shift(edge_mat, shiftv)
  n = length(shiftv);
  in_vec = [-1*shiftv'/1000; zeros(2, n)];
   out_vec = edge_mat * in_vec;
   ka = out_vec(2,:)';
end

%!test
%! func_name(x)
