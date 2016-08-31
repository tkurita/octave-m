#useOwnTerm

a2pm2_1 = csvread("A2_PM2_20160831.csv");
a2pm2_1(1,:) = [];

hz = a2pm2_1(:,2);
hzlist = linspace(hz(1), hz(end), 200);
a2 = a2pm2_1(:,3);
pm2 = a2pm2_1(:,4);
ampvlist = HzToAmpControlV(hzlist, a2pm2_1, "fitorder", 13);
pmvlist = HzToPhaseControlV(hzlist, a2pm2_1, "fitorder", 8);
#set(0, "defaultlinewidth", 2)
plot(hz, a2, "*;Amplitude Control vs Frequency;","markersize", 10,...
   hzlist, ampvlist, "-", "linewidth", 3,...
   hz, pm2, "*;Phase Control vs Frequency;", "markersize", 10,...
   hzlist, pmvlist, "-", "linewidth", 3);
xlabel("[Hz]");ylabel("[V]");grid on;
# save_plot("A2_PM2_20161231.pdf");

ampvlist_interp = HzToAmpControlV(hzlist, a2pm2_1, "method", "interp");
pmvlist_interp = HzToPhaseControlV(hzlist, a2pm2_1, "method", "interp");

plot(hz, a2, "*;Amplitude Control vs Frequency;","markersize", 10,...
   hzlist, ampvlist_interp, "-", "linewidth", 3,...
   hz, pm2, "*;Phase Control vs Frequency;", "markersize", 10,...
   hzlist, pmvlist_interp, "-", "linewidth", 3);
xlabel("[Hz]");ylabel("[V]");grid on;



