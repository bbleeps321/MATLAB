clear; close all;
r1 = 100; r2 = 100;
c1 = 1e-6; c2 = 1e-6;
A = [-(1/r1+1/r2)/c1 -1/(c1*r2); -1/(c2*r2) -1/(c2*r2)]
B = [(1/r1+1/r2)/c1; 1/(c2*r2)]
C = [0 -1]
D = 1
sys = ss(A,B,C,D);

L = eig(A)

step(sys);
ylabel('Voltage');
figure;
bode(sys);