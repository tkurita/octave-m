a2pm2_1 = csvread("A2_PM2_20090713.csv")
a2pm2_1(1,:) = []

load("A2_PM2.dat")
hz = A2_PM2(:,2);
A2 = A2_PM2(:,3);
PM2 = A2_PM2(:,4);
plot(hz, A2, "-*",...
   hz, PM2, "-*",...
   a2pm2_1(:,2), a2pm2_1(:,3), "-*",...
   a2pm2_1(:,2), a2pm2_1(:,4), "-*")


hz = a2pm2_1(:,2);
hzlist = linspace(hz(1), hz(end), 200);
a2 = a2pm2_1(:,3);
pm2 = a2pm2_1(:,4);
ampvlist = HzToAmpControlV(hzlist, a2pm2_1);
pmvlist = HzToPhaseControlV(hzlist, a2pm2_1);
set(0, "linewidth", 2)
plot(hz, a2, "*;Amplitude Control vs Frequency;","markersize", 10,...
   hzlist, ampvlist, "-", "linewidth", 3,...
   hz, pm2, "*;Phase Control vs Frequency;", "markersize", 10,...
   hzlist, pmvlist, "-", "linewidth", 3);
xlabel("[Hz]");ylabel("[V]");grid on;
print_pdf("A2_PM2_20090713.pdf")

