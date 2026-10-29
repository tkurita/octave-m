#useOwnTerm
if false
  system("iqt2fft 003.iqt > 003.csv");
endif
specdata= load_spectrum_csv("003.csv");
plot_spectrum(specdata, "x", "MHz")
if false
  save_plot("003-1.pdf");
endif
plot_spectrum(specdata, "x", "MHz", "usepcolor");
##  save_plot("003-2.pdf")

plot_spectrum(specdata, "gpscript", "003.gp") 
system("gnuplot -persist 003.gp -e 'pause -1'") # 遅い。

stime = 30
frev = 1.32
fwidth = 0.03

peaktrace1 = trace_peak_spectrum(specdata, frev, fwidth,...
                                "starttime", stime);
append_plot([peaktrace1.freq, peaktrace1.t] , "-", "color", "black");
peaktrace2 = trace_peak_spectrum(specdata, 1.77, fwidth,...
                                "starttime", stime);
append_plot([peaktrace2.freq, peaktrace2.t], "-", "color", "black");
save_plot("paek_trace.pdf");

3- peaktrace2.freq./peaktrace1.freq

## スペクトラムデータを peak trace で分割
## 何のためか？
spec_lr = split_spectrum(specdata, peaktrace1);
plot_spectrum(spec_lr{1}, "x", "MHz")
save_plot("spec_lr_1.pdf")
plot_spectrum(spec_lr{2}, "x", "MHz")
save_plot("spec_lr_2.pdf")

## 周波数を tune に変換してプロット
plot_tunespectrum(spec_lr{1}, peaktrace1, inline("f./frev +1"))
##  save_plot("tunespec_1.pdf");
plot_tunespectrum(spec_lr{2}, peaktrace1, inline("3-f./frev"),...
                "output", "tunespec_r.gp")
system("gnuplot -p tunespec_r.gp -e 'pause -1'");
