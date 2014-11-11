data = load('dye.dat');

N = length(data);   % Number of points
a = data(1,1);      % First point value
b = data(N,1);      % Last point value
h = data(2,1) - data(1,1);  % Time intervals (assume constant).

% Rectangular integration (left side)
integ1 = h*sum(data(1:(N-1),2));

% Trapezoidal integration
integ2 = .5*h*(data(1,2) + data(N,2) + 2*sum(data(2:(N-1),2)));

% Simpson's integration
integ3 = (1/3)*h*(data(1,2) + data(N,2) + 4*sum(data(2:2:(N-1),2)) + 2*sum(data(3:2:(N-2),2)));

% MATLAB trapz function
integ4 = trapz(data(:,1),data(:,2));

% Prompt for input
injected = input('Please enter amount of injected dye (mg): ');

% Calculate cardiac input for each of the 4 approximations
Q1 = injected/integ1*60;   % Convert to L/min
Q2 = injected/integ2*60;
Q3 = injected/integ3*60;
Q4 = injected/integ4*60;

% Output approximations, Q, and data plot
disp(sprintf('Type\tApprox. area\tQ (L/min)\n'));
disp(sprintf('R\t\t%0.4f\t\t%0.4f\n',integ1,Q1));
disp(sprintf('T\t\t%0.4f\t\t%0.4f\n',integ2,Q2));
disp(sprintf('S\t\t%0.4f\t\t%0.4f\n',integ3,Q3));
disp(sprintf('trapz\t%0.4f\t\t%0.4f\n',integ4,Q4));
plot(data(:,1),data(:,2),'o');
title('Dye Concentration vs Time');
xlabel('Time (s)');
ylabel('Dye Concentration (mg/L)');
axis([0 32 0 34]);