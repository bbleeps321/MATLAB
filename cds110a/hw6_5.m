clear; close all;
bike_linmod;
v0 = 5; r = 0; tf = 10;
A = [0 0 1 0; 0 0 0 1; -M\[K0+K2*v0^2 C*v0]];
B = [0; 0; M\[0;1]];
C = [0 1 0 0];
options = odeset('RelTol', 1e-6, 'AbsTol', [1e-6]);

% State feedback gain
K = place(A,B,[-2;-10;-1+1i;-1-1i]);

% Observer gain
L = place(A',C',[-4;-20;-2+2i;-2-2i])';

clear tf;
controller = tf(ss(A-B*K-L*C,L,K,0))
figure; bode(controller);, grid on;

bike_sys = tf(ss(A,B,C,0));
loop = controller*bike_sys
figure; bode(loop); grid on;
figure; amnyquist(loop); grid on;
[Gm,Pm]=margin(loop)
figure; pzmap(loop);
closedLoop = controller*bike_sys/(1+controller*bike_sys)
figure; step(closedLoop);