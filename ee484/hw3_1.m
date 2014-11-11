clear; close all;

% a) Plot frequency response of filter
NumTaps = 17;
Alpha = 0.22;
TimeDelay = 0;
Sps = 16;
fs = 16;
h = SqrcFilter(Alpha,NumTaps,Sps,TimeDelay);
[H,F] = freqz(h,1,2048,fs);

plot(20*log10(abs(H)/max(abs(H))+0.0001));
title('Frequency Response of Root Raised Cosine with \alpha=0.22');
xlabel('Normalized frequency'); ylabel('dB');
grid on;

% Energy normalization
h = h/sqrt(sum(h.^2));

% b) Plot correlation of filters
corr = conv(h,fliplr(h));
figure;
plot(corr); grid on;
title('Correlation of Transmit and Receive Filters');

% c) Plot received and filtered stream of random bits.
NumBits = 32;
b = ones(1,NumBits).*(rand(1,NumBits) > 0.5);
b = 2*b-1;
upsampled = upsample(b,Sps);
received = conv(upsampled,h);
filtered = conv(received,h);
figure;
plot(received); grid on;
title('Received Stream');
figure;
plot(filtered); grid on;
title('Filtered Stream');

% d) Plot received constellations for BPSK signal.

% Sample every Sps points from startIndex (maximum of correlation)
[Y startIndex] = max(corr);
dataReceived = filtered(startIndex:Sps:(startIndex+(NumBits-1)*Sps));
figure;
scatter(real(dataReceived),imag(dataReceived)); grid on;
title('Received Constellation');
axis([-1.5 1.5 -1 1]);

