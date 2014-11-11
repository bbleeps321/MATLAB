W=30; u=450; L=2; tox=350e-8; Vt=.8; eox = 3.9*8.85e-14;
Vds = 0:0.01:5; Kn = W/L*u*eox/tox/2;
%a
for (Vgs = 0:5)
    Id1 = Kn*(2*(Vgs-Vt)*Vds-(Vds.^2)).*(Vds<(Vgs-Vt)&Vds>Vt);
    Id2 = Kn*(Vgs-Vt)^2.*(Vds>=(Vgs-Vt));
    Id = Id1+Id2;
    plot(Vds,Id);
    hold on;
end
title('Id vs Vds');
xlabel('Vds'); ylabel('Id');
%b
Vgs = 0:.01:5;
rtIdsat = sqrt(Kn)*(Vgs-Vt);
figure; plot(Vgs,rtIdsat);
title('sqrt(Id(sat)) vs Vgs'); xlabel('Vgs'); ylabel('sqrt(Id(sat))');
%c
Vds = .1;
Id1 = Kn*(2*(Vgs-Vt)*Vds-(Vds.^2));
% Id2 = Kn*(Vgs-Vt)^2.*(Vds>=(Vgs-Vt));
Id = Id1+Id2;
plot(Vgs,Id);
title('Id vs Vgs');
xlabel('Vgs'); ylabel('Id');