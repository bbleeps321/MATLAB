function project
    clear; close all; clc;
    load aud2;
    % y, fs defined
    N = length(y);
    r = 4;
    % fft
    h = fir1(256,1/4);
    yfiltfft = conv(y,h,'same');
    
    % fwt
    qmf = MakeONFilter('Haar');
    wft = FWT_PO(y,1,qmf);
    i=(1:N)';
    yfiltwft = IWT_PO(wft.*(i<N/r),1,qmf);
%     sound(yfiltwft,fs);
    
    % compare errors
    fprintf('FFT error: %f\n',sum((yfiltfft-y).^2)/N);
    fprintf('WFT error: %f\n',sum((yfiltwft-y).^2)/N);
end