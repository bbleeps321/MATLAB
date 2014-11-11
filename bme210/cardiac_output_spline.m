data = load('dye.dat');

% interpolate
t = 0:.1:30;
interp = [t; spline(data(:,1),data(:,2),t)]';

% plot
plot(data(:,1),data(:,2),'o',interp(:,1),interp(:,2),'-');
title('Dye Concentration vs Time (Interpolated)');
xlabel('Time (s)');
ylabel('Dye Concentration (mg/L)');
axis([0 32 0 34]);