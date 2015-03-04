load("PhaseShifter.dat")
rad = PhaseShifter(:,3);
v = PhaseShifter(:,4);
radlist = linspace(rad(1), rad(end), 200);
vlist = radToControlV(radlist, PhaseShifter);

plot(v, rad, "*", vlist, radlist, "-");
xlabel("[V]"); ylabel("[rad]"); grid on

print_pdf("PhaseShifter.pdf")