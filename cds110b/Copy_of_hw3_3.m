clear; close all;
M = 10; m = 1; g = 9.8; l = 10; l0 = 1;
var = .01; sigma = sqrt(var);
d = m-(M+m);
x0 = .15*ones(4,1);
t = 0:0.01:100;

% up
A = [0 0 1 0; 0 0 0 1; 0 -g*m/M 0 0; 0 g*(M+m)/(M*l) 0 0];
B = [0; 0; 1/M; -1/(M*l)];
C = [1 l0 0 0];
D = 0;
sys = ss(A,B,C,D);

R = 1;
Q = C'*C;

[K,P] = lqr(sys,Q,R);
sysC = ss(A-B*K,B,C,D);
[kalmf,L] = kalman(sysC,var,var);

% x = lsim(sysC,zeros(size(t)),t,x0);
% [kalmf,L,P] = kalman(plant,var,var);
% xhat = lsim(kalmf(2:5,:),[C*x'+v; w]',t,x0);

% sysCO = ss(A-B*K-L*C,B,eye(4),D);
controller = ss(A-B*K-L*C,L,K,0);
sysCO = sys*controller/(1+sys*controller);

x = lsim(sysCO,normrnd(0,sigma,size(t)),t,[x0; zeros(12,1)]);

% Trajectories
figure;
subplot(4,1,1); plot(t,x(:,1));
title('Position trajectory'); xlabel('Time (s)'); ylabel('Position (m)');
subplot(4,1,2); plot(t,x(:,2));
title('Angle trajectory'); xlabel('Time (s)'); ylabel('Angle (rad)');
subplot(4,1,3); plot(t,x(:,3));
title('Velocity trajectory'); xlabel('Time (s)'); ylabel('Velocity (m/s)');
subplot(4,1,4); plot(t,x(:,4));
title('Angular velocity trajectory'); xlabel('Time (s)'); ylabel('Angular velocity (rad/s)');