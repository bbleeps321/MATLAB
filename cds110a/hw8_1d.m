clear; close all;

z = 0:.001:1;
Pm = atan2d(2*z,sqrt(sqrt(1+4*z.^4)-2*z.^2));
Mp = exp(-pi*z./sqrt(1-z.^2));

figure; plot(Pm,Mp);
title('Overshoot vs Phase Margin');
xlabel('Phase margin (degrees)'); ylabel('Overshoot');