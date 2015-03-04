#useOwnTerm
system("iqt2fft 003.iqt > 003.csv");
specdata= load_spectrum_csv("003.csv");
plot_spectrum(specdata, "x", "MHz")
plot_spectrum(specdata, "x", "MHz", "usepcolor");
plot_spectrum(specdata, "gpscript", "003.gp")
system("gnuplot -persist 003.gp")

stime = 30
frev = 1.32
fwidth = 0.03

peaktrace1 = trace_peak_spectrum(specdata, frev, fwidth,...
                                "starttime", stime);
append_plot([peaktrace1.freq, peaktrace1.t] , "-");
peaktrace2 = trace_peak_spectrum(specdata, 1.77, fwidth,...
                                "starttime", stime);
append_plot([peaktrace2.freq, peaktrace2.t], "-");

3- peaktrace2.freq./peaktrace1.freq

spec_lr = split_spectrum(specdata, peaktrace1);
plot_spectrum(spec_lr{1}, "x", "MHz")
plot_spectrum(spec_lr{2}, "x", "MHz")

plot_tunespectrum(spec_lr{1}, peaktrace1, inline("f./frev +1"))
plot_tunespectrum(spec_lr{2}, peaktrace1, inline("3-f./frev"),...
                "output", "tunespec_r.gp")



