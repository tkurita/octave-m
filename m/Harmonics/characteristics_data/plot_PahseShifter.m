#useOwnTerm
load("PhaseShifter.dat")
rad = PhaseShifter(:,3);
v = PhaseShifter(:,4);
radlist = linspace(rad(1), rad(end), 200);
vlist = radToControlV(radlist, PhaseShifter);

plot(v, rad, "*", vlist, radlist, "-");
xlabel("Phase Control [V]"); ylabel("Phase Shift [rad]");grid on

#print_pdf("PhaseShifter.pdf")
#save_plot("PhaseShifter.pdf")