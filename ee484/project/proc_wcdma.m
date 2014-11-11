clear; close all;

raw = read_complex_binary('wcdma_2152p5_data.bin');
raw = real(raw);
% Generate primary sync sequence, resample to appropriate rates.
psync = real(wcdma_psync());
psync = resample(psync,125,48);

% Correlate and plot against primary sync.
% Because of the low energy, we need to split the signal into 38400 chip
% sections and average the energy.
frameL = 38400;
numSect = floor(length(raw)/frameL);
x = reshape(raw(1:numSect*frameL),numSect,frameL);

% Correlate each frame
y = zeros(size(x));
for (i=1:size(x,1))
    y(i,:) = conv(x(i,:),fliplr(psync),'same');
end

average = sum(y,1); % Average along each frame.

plot(abs(average));
title('Primary Sync Correlation');

[m i] = max(abs(average))

% Try to find scrambling codes.
group = 0:30;
id = 0:7;
idx = 1;
% scrCode = zeros(2560,31*8);
% nInt = zeros(1,31*8);
% m = zeros(1,length(nInt));
N = 2*frameL;
corrs = zeros(31*8,N);
disp(['Index        Code Grp      ID      nInt     Max']);

for (i = 1:length(group))
    for (j = 1:length(id))
        nInt = 16*group(i)+8*id(j);
        scrCode = real(WCDMAScrCode(nInt));
        scrCode = resample(scrCode,125,48);
        corrs(idx,:) = conv(raw(1:N),fliplr(scrCode),'same');
%         corrs(idx,:) = xcorr(raw(1:N),scrCode,'same');
        m = max(corrs(idx,:));
        disp([idx group(i) id(j) nInt m]);
        
%         subplot(16,16,idx);
%         plot(corrs(idx,:));
%         title(sprintf('Code %d.%d',i,j));
        idx = idx + 1;
    end
end


% for (i = 1:size(scrCode,2))
%     corrs(i,:) = conv(raw(1:50000),fliplr(scrCode(:,i)),'same');
%     m(i) = max(corrs(i,:));
% end
% 
% disp([[1:31*8]' floor(nInt/16)' m']);
