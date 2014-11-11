% Takes in a vector audio signal and sampling rate.
% Outputs a vector of times for when the beats are.
function bpm = beatdetect(y,fs)
%     N = 1024;
    L = length(y);
    npulse = 3;
    maxfreq = 4096;
    minbpm = 60;
    maxbpm = 240;
    bpminc = 1;
    
    % Divide frequency bands
    yft = fft(y,L+1)';
    ndiv = 8;
    cutoff = 1:L/ndiv:(L+1);
%     ndiv = length(cutoff)
    for i = 1:ndiv-1
        dft(i,:)=yft(cutoff(i):cutoff(i+1));
    end
    
    % Find energy of signal convolved with various bpm signals
    bpm = minbpm:bpminc:maxbpm; 
    nbpm = length(bpm);
    e = zeros(1,nbpm);
    for (i=1:nbpm)
        pulse = zeros(1,L/ndiv+1);
        step = floor(60/bpm(i)*fs);
        pulse(1:step:(npulse*step)) = 1;
        
        % energy after convolution
        pulseft = fft(pulse,L/ndiv+1);
        for j=1:(ndiv-1)
            e(i) = e(i) + sum((abs(pulseft.*dft(j,:))).^2);
        end
    end
    
    plot(e);
    [m i] = max(e);
    bpm = bpm(i);
%     fprintf('Song tempo: %d bpm\n',bpm);
end