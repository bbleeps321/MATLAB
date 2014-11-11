clear; close all;
w = 0:.01:10; % normalized freq
Q = [1 3 6 10];
rgb = 'rgbk';
A = zeros(length(Q),length(w));
for (i = 1:length(Q));
    A(i,:) = abs(1./(1+1i*Q(i)*(w-w.^-1)));
    plot(w,A(i,:),rgb(i));
    hold on;
end
title('Normalized Transfer Function vs Normalized Frequency');
xlabel('Normalized Frequency'); ylabel('Normalized Gain');
legend('Q=1','Q=3','Q=6','Q=10');