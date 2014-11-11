clear; close all;

% Generate GPS Codes 1-24
g = cacode(1:24);

% a) Spread GPS code with rectangular pulse. Plot first code.
% Plot first code
Sps = 4;
b = 2*g-1;
h = ones(1,Sps);
code = zeros(24, length(g(1,:))*Sps + length(h) - 1);

for (i = 1:24)
    code(i,:) = conv(upsample(b(i,:),Sps),h);
end

% Generate random bits and spread them by each GPS code.
NumBits = 8;
b = ones(24,NumBits).*(rand(24,NumBits) > 0.5);
b = 2*b-1;
% upsampled = upsample(b,Sps);
waveform = zeros(24, (NumBits+1)*length(code(1,:)) - 1);
for (i = 1:24)
    waveform(i,:) = conv(upsample(b(i,:),length(code(i,:))), code(i,:));
end

plot(waveform(1,:));
title('First Waveform (random bits and code 1)');
xlabel('Time');

% b) Calculate average autocorrelation for each of the first 24 codes.
acorr = zeros(24,2*size(waveform,2)-1);
for (i = 1:24)
    acorr(i,:) = conv(waveform(i,:),fliplr(waveform(i,:)));
end
figure;
plot(mean(acorr));
title('Average autocorrelation');

% c) Calculate average cross-correlation between all the first 24 codes.
xcorr = zeros(1,2*size(waveform,2)-1);
nextCorr = 1;
for (i = 1:24)
    for (j = (i+1):24)
        xcorr(nextCorr,:) = conv(waveform(i,:),fliplr(waveform(j,:)));
        nextCorr = nextCorr+1;
    end
end
figure;
plot(mean(xcorr));
title('Average cross-correlation');