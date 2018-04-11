function obj = QMKick(lvtable ,lattice)
  % obj = QMKick(LevelTableBM)
  %     evaluate kick angles with QM
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
  end
  dyds = [];
  for n = 1:length(lvtable.names)
    qm = element_with_name(lattice, lvtable.names{n});
    dyds(end+1) = kick_with_QM_shift(qm, lvtable.data(n), "v");
  end
  obj.dyds = dyds';
  obj.names = lvtable.names;
  obj = class(obj, "QMKick");
end

%!test
%! func_name(x)
