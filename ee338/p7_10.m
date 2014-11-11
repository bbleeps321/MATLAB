Vgs = 0:.01:5;
un = 500; WL = 10; Cox = 6.9e-8; Vt = 1;
Id1 = sqrt(un*WL*Cox/2)*(Vgs-Vt);

u0 = 1000; ec = 2.5e4;
tox = 3.9*8.85e-14/Cox;
ueff = u0*(Vgs/tox/ec).^(-1/3);
Id2 = sqrt(ueff*WL*Cox/2).*(Vgs-Vt);

plot(Vgs, Id1,'r'); hold on;
plot(Vgs, Id2,'b');
xlabel('Vgs'); ylabel('sqrt(I_D)');
legend('Constant \mu', 'Nonconstant \mu');