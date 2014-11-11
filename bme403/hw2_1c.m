close all; clear; clc;
f = .1:.01:1;
R = 2.5;
C = .1;
Vd = .15;
Va = .1;
Vt = Va./f+Vd;
power = 2*f.^2*R.*Vt.^2+f.*Vt.^2./(2*C);
plot(f,power);
title('Power vs Frequency');
xlabel('Frequency (Hz)');
ylabel('Power (mmH_2O*L/s)');

% find optimal frequency
[y i] = min(power);
text(.3,.55,sprintf('Optimal f = %f Hz',f(i)));
hold on;
plot(f(i),y,'o');