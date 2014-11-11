close all; clear; clc;
T = 200:600;
Nc = [2.8e19 1.04e19 4.7e17];
Nv = [1.04e19 6e18 7e18];
Eg = [1.12 .66 1.42];
kt = .0259*T/300;
rgb = 'rgb';
for (i=1:3)
    hold on;
    plot(T,log10(Nc(i).*Nv(i).*(T/300).^3.*exp(-Eg(i)./kt)),rgb(i));
end
xlabel('T (K)'); ylabel('log(n_i)');
title('n_i vs T');
legend('Si','Ge','GaAs');