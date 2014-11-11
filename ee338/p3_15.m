clear; close all;
T=200:600;
kT = .0259*(T/300);
Nc = 4.7e17*(T/300).^1.5;
Nv = 7e18*(T/300).^1.5;
Efi = .5*kT.*log(Nv./Nc);
plot(T,Efi);
title('E_{Fi} relative to midgap in GaAs');
xlabel('T (K)'); ylabel('E_{Fi} - E_{midgap}');