tt = tune_trace("003.csv")
stime = 30
frev = 1.32
fwidth = 0.03
#tt.trace_peak(frev, "fwidth", fwidth, "starttime", stime)
tt.trace_frev(frev, "fwidth", fwidth, "starttime", stime);
tt.trace_hsb(1.77);
tt.trace_lsb(0.93);
disp(tt)
tt.plot_spectrum();
pause
# save_plot("003-3.pdf");
tune = tt.calc_tune(@(df, f) 2 - df./f);
xyplot(tune);grid on;xlabel("[ms]");ylabel("horizontal tune");
pause
# save_plot("horizontal_tune.pdf");
disp("finish");

