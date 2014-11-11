clear; close all;

fs = 2.4e3;
N = 2048
t = 0:1/fs:((N-1)*1/fs); % length 2048
x = 1.5*sin(400*pi*t)+.75*cos(800*pi*t)+2*sin(1200*pi*t);

subplot(1,2,1);
plot(0:(N-1), x); axis([0 N min(x) max(x)]);
title('x[n]'); xlabel('n'); ylabel('x[n]');

X = fft(x);
subplot(1,2,2);
plot((0:(N-1))-N/2,abs(fftshift(X))); axis([-N/2 N/2 0 max(abs(X))]);
title('X[k]'); xlabel('k'); ylabel('X[k]');
