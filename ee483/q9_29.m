w=0:.01:pi;
z=exp(1i*w);
GLP = .1944*(1+.9802*z.^-1+z.*-2)./(1-.7016*z.^-1+.281*z.^-2);
Gd = .1944*(1-3.208*z.^-1-.9762*z.^-2-3.208*z.^-3+z.^-4)./(1+.0815*z.^-1+.7894*z.^-2-.0088*z.^-3+.281*z.^-4);
plot(w,20*log10(abs(GLP)),'b');
hold on;
plot(w,20*log10(abs(Gd)),'r');
title('LP and BP filters');
xlabel('\omega');ylabel('Gain dB');