K = 5; wc = .3*pi;
C = 2^((K-1)/K);
a = (1+(1-C)*cos(wc)-sqrt(2*C-C^2)*sin(wc))/(1-C+cos(wc))
w = -pi:.01:pi;
H = (((1-a)^2*(1+cos(w)))./(2*(1+a^2-2*a*cos(w)))).^K;
plot(w,20*log10(abs(H)));
axis([-pi pi -5 0]);
title('Frequency Response of Filter');
xlabel('\omega'); ylabel('gain (dB)');