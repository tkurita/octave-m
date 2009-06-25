load("A2_PM2.dat")
hz = A2_PM2(:,2);
A2 = A2_PM2(:,3);
wpolyfit(hz,A2,12);xlabel("[Hz]");ylabel("A2 [V]");grid on;
print_pdf("A2vsHz.pdf");

PM2 = A2_PM2(:,4);
wpolyfit(hz,PM2,12)
xlabel("[Hz]");ylabel("PM2 [V]");grid on
print_pdf("PM2vsHz.pdf");

