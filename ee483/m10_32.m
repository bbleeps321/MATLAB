dp = 1-10^(-.15/20); ds=10^(-45/20);
[N Fo Ao W] = firpmord([.1 .25], [1 0], [dp ds]);
H = (1-exp(-1i*.25*pi*(N+1)))/(1-exp(-1i*.25*pi)); %weight for stop band
b = firpm(N, Fo, Ao, [1 dp/ds*H]);
disp('FIR Filter Coefficients'); disp(b)
[h,w] = freqz(b,1,256);
plot(w/pi,20*log10(abs(h)));grid;
xlabel('\omega/\pi'); ylabel('Gain, dB');