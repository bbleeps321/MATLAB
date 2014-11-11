clear; close all;
kp = 50; Ti = 1/500;
P = tf(1,[1 1]);
C = tf([kp*Ti 1],[Ti 0]);

closedLoop = P*C/(1+P*C);
figure; bode(closedLoop);
figure; step(closedLoop);