clear; close all;
bike_linmod;
v0 = 5; r = .002; tf = 10;
A = [0 0 1 0; 0 0 0 1; -M\[K0+K2*v0^2 C*v0]]
B = [0; 0; M\[0;1]];
OutputMatrix = [0 1 0 0];
options = odeset('RelTol', 1e-6, 'AbsTol', [1e-6]);

bikeFullState = @(t,x,K,kr) (A-B*K)*x + B*kr*r;
bikeOutputFB = @(t,x,K,L,kr) [A-B*K B*K; ...
    zeros(4) A-L*OutputMatrix]*x + [B*kr; zeros(4,1)]*r;

% State feedback gain
K = place(A,B,[-2;-10;-1+1i;-1-1i])
kr = inv(OutputMatrix*inv(A-B*K)*B)
init = 1e-4*(rand(8,1)-1);
[t,x] = ode45(bikeFullState,[0 tf],init(1:4),options,K,kr);
subplot(2,1,1); hold on; plot(t,x(:,2),'r');
xlabel('time'); ylabel('Steering angle \delta');
title('Bicycle system response to step-change reference 0.002rad');
subplot(2,1,2); hold on; plot(t,-K*x'+kr*r,'r');
xlabel('time'); ylabel('Command torque');

% Observer gain
L = place(A',OutputMatrix',[-4;-20;-2+2i;-2-2i])'
[t,x] = ode45(bikeOutputFB,[0 tf],init,options,K,L,kr);
subplot(2,1,1); plot(t,x(:,2),'b--');
subplot(2,1,2); plot(t,-K*(x(:,1:4)-x(:,5:8))'+kr*r,'b--');
legend('Full state feedback','Output feedback');