w = 0:.01:pi;
z = exp(1i*w);
G = .2397*(1-1.5858*z.^-1+1.5858*z.^-2-z.^-3)./(1+.3272*z.^-1+.7459*z.^-2+.179*z.^-3);
H = .269889*(1-1.80643*z.^-1+1.80643*z.^-2-z.^-3)./(1+.0505626*z.^-1+.701093*z.^-2+.1356*z.^-3);
plot(w,20*log10(abs(G)),'b'); hold on;
plot(w,20*log10(abs(H)),'r');
legend('G_H_P(z)','H_H_P(z)');
title('Gain Responses');
xlabel('Frequency (\omega)'); ylabel('Gain (dB)');