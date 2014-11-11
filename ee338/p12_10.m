Nd = 1e19; Na = 3e16; Dp = 6; Dn = 18; Tp = 5e-7; Tn = 5e-6;
e = 1.6e-19; ni = 1.5e10; JL = 25; A = 2; V = 0:.01:5;
IL = JL*A
Ln = sqrt(Dn*Tn); Lp = sqrt(Dp*Tp);
Is = (e*ni^2*(Dn/(Ln*Na) + Dp/(Lp*Nd)))*A
I = IL - Is*(exp(V/.0259)-1);
plot(V,I); xlabel('V'); ylabel('I'); axis([0 2 0 60]);