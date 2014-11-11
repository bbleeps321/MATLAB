clear; close all;

% Plot firing rates for all directions given preferred direction of 0. 
th = (0:10:350)*pi/180;   % angles to go through, in radians
Rmax = 40;
Rmean = 20;
Rmin = 0;
Dpref = 0;
R = (Rmax-Rmean)*cos(th-Dpref)+Rmean;
figure;
polar(upsample(th,2),upsample(R,2));
title('Firing rates for various directions, preferred dir = 0');

% Random preferred directions, actual direction 0. Plot weighted preferred
% direction vectors for 30 neurons.
N = 30;
th = 2*pi*rand(1,30);
Dact = 0;
R = (Rmax-Rmean)*cos(th-Dact)+Rmean;
w = (R-Rmean)/(Rmax-Rmin);
% wR = w.*R;

% Plot. Insert zeros so each vector from origin.
figure;
% polar(upsample(th,2),upsample(wR,2),'g');
polar(upsample(th,2),upsample(w,2),'g');
title('Firing rates for 30 randomly oriented neurons, actual direction 0');

% Calculate predicted sum.
hold on;
pred = [sum(w.*cos(th)) sum(w.*sin(th))];

% Plot actual direction.
polar([0 0],[0 1],'r'); % Unit vector

% Plot predicted direction.
polar([0 atan(pred(2)/pred(1))],[0 1],'b');   % Unit vector
legend('Individual','Actual','Predicted');
disp('Error (deg) = ');
disp(atan(pred(2)/pred(1))*180/pi);