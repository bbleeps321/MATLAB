M = 20; n = -M:M;
filter = .5*sinc(.5*n).*(1-abs(n)/(M+1));
[h,w] = freqz(filter,1,512);
plot(w/pi,20*log10(abs(h)));% grid;
xlabel('\omega/\pi'); ylabel('Gain, dB');