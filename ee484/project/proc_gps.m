clear; close all;

raw = read_complex_binary('gps_L1_s5MHz.bin')';

% Convert to baseband
% raw = raw.*exp(-2j*pi*1.57542e9*(1:length(raw))/5e6);
% x = real(raw)';  % signal data is on the I.

% Get g codes with frequency offsets
g = cacode(1:24);


% size(g)
% size(x)

% n = 1:size(x(2));
% offsets = zeros(1,24);
% offsets([2 6 12 18 7 9 22]+1) = [848.77 1087.19 858.307 2546.31 ...
%                                 2088.55 696.182 -915.527];
% xoffset = zeros(24,size(x));
% for (i = 1:length(offsets))
%     xoffset(i,:) = exp(-1i*2*pi*offsets(i)*n/5e6);
%     g(i,:) = real(g(i,:).*xoffset(i,:));
% end

% g = resample(g',5000,1023)';

% n = 1:size(g(2));
% offsets = zeros(1,24);
% offsets([2 6 12 18 7 9 22]) = [848.77 1087.19 858.307 2546.31 ...
%                                 2088.55 696.182 -915.527];
% xoffset = ones(24,size(g,2));
% for (i = 1:length(offsets))
%     xoffset(i,:) = exp(-1i*2*pi*offsets(i)*n/5e6);
% %     g(i,:) = real(g(i,:).*xoffset(i,:));
% end


N = 20000;
% y = zeros(24,N+length(g)-1);
y = zeros(24,N);
n = 1:N;
offsets = zeros(1,24);
offsets([2 6 12 18 7 9 22]+1) = [848.77 1087.19 858.307 2546.31 ...
                                2088.55 696.182 -915.527];
figure;
for (i = 1:24)
%     h = real(fliplr(g(i,:)).*xoffset(i,:));
    h = fliplr(resample(g(i,:),5000,1023));
    xoffset = exp(-2j*pi*offsets(i)*n/5e6);
    y(i,:) = conv(raw(1:N).*xoffset,h,'same'));
%     y(i,:) = ifft(fft(real(raw(1:N).*xoffset),N).*fft(g(i,:),N));
    subplot(4,6,i);
    plot(y(i,:));
    title(sprintf('Code %d',i));
end

disp('code          max value');
disp([(1:24)' max(y')']);



% 
% % offsets = zeros(1,24);
% % offsets([2 6 12 18 7 9 22]-1) = [848.77 1087.19 858.307 2546.31 ...
% %                                 2088.55 696.182 -915.527];
% % xoffset = zeros(24,size(g,2));
% % for (i = 1:length(offsets))
% %     xoffset(i,:) = exp(-1i*2*pi*offsets(i)*n/5e6);
% %     g(i,:) = real(g(i,:).*xoffset(i,:));
% % end
% % g = resample(g',500,384)';
% N = 2^10;
% 
% % length(g(1,:))
% % length(x)
% 
% % Correlate signal against each code.
% % y=zeros(24,N);
% % h = [g zeros(24,length(x)-length(g(1,:)))];
% % length(h(1,:))
% % y = zeros(24,2*length(x)-1);
% g = resample(g',5000,1023)';
% N = 2^nextpow2(1000000+length(g(1,:))-1);
% y = zeros(24,N);
% % length(x)
% 
% % length(g(1,:))
% % y=zeros(24,100000);
% for (i = 1:24)
%     
%     fprintf('.');
%     y(i,:) = ifft(fft(x(1:999999),N).*fft(fliplr(g(i,:)),N));
% %     y(i,:) = conv(x(1:100000),fliplr(g(i,:)),'same'); % too slow
%     subplot(4,6,i);
%     plot(y);
%     title(sprintf('Code %d',i));
% end
% 
% fprintf('\n');
% 
% % Print out table for peak value for each code
% disp([(1:24)' max(y')']);