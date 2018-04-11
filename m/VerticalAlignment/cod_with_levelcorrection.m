function varargout = cod_with_levelcorrection(bm_lvtable, qm_lvtable...
                                        , bpm_lvtable, cod_at_bpms, shiftv)
  % retval = cod_with_levelcorrection(bm_lvtable, qm_lvtable...
  %                                      , bpm_lvtable, cod_at_bpms, shiftv)
  % shiftv を垂直方向の基準として（QM および BM edge のキックの基準）として、
  % BM と QM の alignment error による COD を計算する。
  % cod_at_bpm は bpm_lvtable と shiftv を考慮して、修正する。
  %
  %== OUTPUT
  % nargout == 1 のとき、struct
  % nargout > 1 のとき、cell array
  %
  if ! nargin
    print_usage();
    return;
  endif
  bm_lvtable = shift_level(bm_lvtable, shiftv);
  qm_lvtable = shift_level(qm_lvtable, shiftv);
  bpm_lvtable = shift_level(bpm_lvtable, shiftv);
  bm_kick = BMKick(bm_lvtable);
  lattice = cod("template").ring;
  qm_kick = QMKick(qm_lvtable, lattice);
  cod_bqm = cod("kickers", [bm_kick.allnames; qm_kick.names] ...
          , "kick_angles", [bm_kick.allkicks; qm_kick.dyds]);
  cod_qm = cod("kickers", qm_kick.names, "kick_angles", qm_kick.dyds);
  cod_bm = cod("kickers", bm_kick.allnames ...
          , "kick_angles", bm_kick.allkicks);
  # bpm_lvtable.data
  for n = 1:length(bpm_lvtable.names)
    a_name = bpm_lvtable.names{n};
    cod_at_bpms.at_bpms.(a_name) += bpm_lvtable.data(n);
  end
  xyplot(by_kickers(cod_bqm), "-;BM and QM;" ...
        , by_kickers(cod_qm), "-;QM;" ...
        , by_kickers(cod_bm), "-;BM;" ...
        , vs_positions(cod_at_bpms), "-*;measured COD;");
    grid on;
  if nargout > 1
    varargout = {cod_bqm, cod_bm, cod_qm, cod_at_bpms};
  elseif nargout == 1
    varargout = {struct("BQM", cod_bqm, "BM", cod_bm ...
                      , "QM", cod_qm, "BPM", cod_at_bpms)};
  end
endfunction

%!test
%! func_name(x)
