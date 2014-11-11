Wp = input('Passband edge frequency = ');
Ws = input('Stopband edge frequency = ');
Rp = input('Passband ripple in dB = ');
Rs = input('Minimum stopband attenuation = ');
[N,Wn] = ellipord(Wp, Ws, Rp, Rs);
[b,a] = ellip(N,Rp,Rs,Wp)
[h,omega] = freqz(b,a,256);
gain = 20*log10(abs(h));
plot (omega/pi,gain);grid;
xlabel('\omega/\pi'); ylabel('Gain, dB');
title('IIR Elliptic Lowpass Filter');