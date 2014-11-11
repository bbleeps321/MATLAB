clear; close all;
t = 0:.01:100;
Q = [1 6 10];
rgb = 'rgb';
for (i = 1:length(Q));
    y = 2/sqrt(4*Q(i)^2-1)*exp(-t/(2*Q(i))).*sin(sqrt(4*Q(i)^2-1)*t/(2*Q(i)));
    plot(t,y,rgb(i));
    hold on;
end
title('Step Response for Different values of Q');
xlabel('Normalized time (\omega_ot)'); ylabel('Voltage');
legend('Q=1','Q=6','Q=10');