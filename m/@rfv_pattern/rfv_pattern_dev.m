#useOwnTerm

Proton200MeVRFPattern

fs = 10e3; # サンプリング周波数 [Hz]
ts = 1/fs;

t_msec = (0:ts:2)*1e3;
rfvp = rfv_pattern(rfPattern_7200_10_50_300_400_50_20090624)

save_csv(rfvp, "out.csv")