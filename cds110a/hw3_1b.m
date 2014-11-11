clear; close all;
m = 250; k = 50; c = 10;
A = [0 0 1 0; 0 0 0 1; -2*k/m k/m -c/m 0; k/m -2*k/m 0 -c/m]
B = [0; 0; 0; k/m]
C = [1 0 0 0; 0 1 0 0]
D = 0
sys = ss(A,B,C,D);

L = eig(A)
figure;
step(sys);
ylabel('Position');

figure;
bodeplot(sys);
title('Frequency Response');