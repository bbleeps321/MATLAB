Nd = 1e19; T = 5e-8; Dn = 225; Dp = 7; JL = 30;
e = 1.6e-19; ni = 1.5e10;
Na = 1e15:1e14:1e18;
Ln = sqrt(Dn*T); Lp = sqrt(Dp*T);
Js = e*ni^2*(Dn./(Ln*Na) + Dp/(Lp*Nd));
Voc = .0259*log(1+JL./Js);
plot(log10(Na),Voc);
xlabel('log10(Na)'); ylabel('VOC');