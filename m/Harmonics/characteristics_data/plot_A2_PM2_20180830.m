#useOwnTerm

basename = "A2_PM2_20180830";
a2pm2_1 = csvread([basename, ".csv"]);
a2pm2_1(1,:) = [];

hz = a2pm2_1(:,2);
hzlist = linspace(hz(1), hz(end), 200);
a2 = a2pm2_1(:,3);
pm2 = a2pm2_1(:,4);
ampvlist = HzToAmpControlV(hzlist, a2pm2_1, "fitorder", 13);
pmvlist = HzToPhaseControlV(hzlist, a2pm2_1, "fitorder", 8);
#set(0, "defaultlinewidth", 2)
plot(hz, a2, "*;Amplitude Control vs Frequency;","markersize", 5,...
   hzlist, ampvlist, "-", "linewidth", 1,...
   hz, pm2, "*;Phase Control vs Frequency;", "markersize", 5,...
   hzlist, pmvlist, "-", "linewidth", 1);
xlabel("[Hz]");ylabel("[V]");grid on;
# save_plot([basename, ".pdf"]);