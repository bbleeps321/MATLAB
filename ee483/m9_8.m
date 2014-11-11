N = 5; Rp = .3; Rs = 45; fs = 100e3;
[z p k] = ellipap(N,Rp,Rs);
[b a] = bilinear(z,p,k,fs);
[h w] = freqz(b,a,256);
subplot(2,1,1);
plot(w/pi,20*log10(abs(h)));
subplot(2,1,2);
plot(w/pi,angle(h));