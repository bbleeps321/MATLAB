clear; close all;

sps = 5e6;
caLen = 5000;
file = 'gps_L1_s5MHz.bin';
f = fopen (file, 'rb');
data = fread (f, [2, caLen*4], 'float32');
signal = data(1,:) + data(2,:)*i;
freqOffset = [848.77, 1087.19, 858.307, 2546.31, 2088.55, 696.182, -915.527];
satID = [3, 7, 13, 19, 8, 10, 23];
sv = 1:32; % space vehicle (SV) # from 1 to 32
ca = cacode(sv,sps/1.023e6);
figure;
for i=1:length(satID)
    signalOffset = signal.*exp(-1i*2*pi*freqOffset(i).*(0:(length(signal)-1))./sps);
    result = xcorr(signalOffset,ca(satID(i),:));
    subplot(2,4,i)
    plot(abs(result));
    title(sprintf('C/A Code %d',satID(i)));
end

result = xcorr(signal,ca(1,:));
subplot(2,4,8);
plot(abs(result));
title('C/A Code 1');
