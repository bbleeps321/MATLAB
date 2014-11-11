% clear; close all;
rossler = @(t,X) [10-X^2];

% Plot (x,y,z)
[t,y]=ode23(rossler,[0 10],[5]);

figure;
plot(t,y);
title('Actual'); xlabel('t'); 

sol = gecEx;