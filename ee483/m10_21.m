f1 = 4.2e3; f2 = 10.5e3; fs = 44.1e3; L = 30; N=L;
lp = fir1(N,f1/fs);
hp = fir1(N,f2/fs,'high');
[LP w] = freqz(lp,1,512);
[HP w] = freqz(hp,1,512);
BP = exp(1i*w).^(-N/2) - (LP + HP);
plot(w/pi,20*log10(abs(LP)),'r');
hold on;
plot(w/pi,20*log10(abs(HP)),'b');
plot(w/pi,20*log10(abs(BP)),'k');
legend('LP','HP','BP');
xlabel('\omega/\pi'); ylabel('Gain, dB');