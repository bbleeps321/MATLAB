clear; close all; clc;
T = 50:200;
Nc = 2.8e19;
En = .045; %ionization energy
Nd = 1e15;
plot(T, 1./(1+.5*Nc/Nd.*exp(-En./(.0259*T))));
title('Unionized donor concentration vs T');
xlabel('T (K)'); ylabel('Concentration (cm^-^3)');