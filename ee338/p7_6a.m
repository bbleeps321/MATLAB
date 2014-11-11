Vds = 0:0.01:5;
Vsat = 4.173;
es = 11.7*8.85e-14; e = 1.6e-19; Na = 4e16; 
Pfp = .383;
dL = sqrt(2*es/e/Na)*(sqrt(Pfp + Vds) - sqrt(Pfp + Vsat));
plot(Vds+Vsat, dL);
title('Channel Length Modulation');
xlabel('Vds (V)'); ylabel('\DeltaL');