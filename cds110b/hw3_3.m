clear; close all;
M = 10; m = 1; g = 9.8; l = 10; l0 = 1;
sigma = .01;
d = m-(M+m);
x0 = .15*ones(4,1);
t = 0:0.01:100;

% up
A = [0 0 1 0; 0 0 0 1; 0 -g*m/M 0 0; 0 g*(M+m)/(M*l) 0 0];
B = [0; 0; 1/M; -1/(M*l)];
C = [1 l0 0 0];
D = 0;
sys = ss(A,B,C,D);
sysObs = ss(A,B,[C;eye(4)],D);

R = 1;
Q = C'*C;
QXU = blkdiag(Q,R);
QWV = sigma*eye(5);
klqg = lqg(sys,QXU,QWV);
sysLQG = feedback(sysObs,klqg,1,1,1);

Clqr = eye(4);
[K,P] = lqr(ss(A,B,Clqr,D),Clqr'*Clqr,R);
sysLQR = ss(A-B*K,B,Clqr,D);

w = normrnd(0,sigma,size(t));
xLQG = lsim(sysLQG,w,t,[x0; x0]);
xLQR = lsim(sysLQR,w,t,x0);

% Trajectories
figure;
subplot(4,1,1); hold on;
plot(t,xLQG(:,2),'b');
plot(t,xLQR(:,1),'g');
title('Position trajectory'); xlabel('Time (s)'); ylabel('Position (m)');
subplot(4,1,2); hold on;
plot(t,xLQG(:,3),'b');
plot(t,xLQR(:,2),'g');
title('Angle trajectory'); xlabel('Time (s)'); ylabel('Angle (rad)');
subplot(4,1,3); hold on;
plot(t,xLQG(:,4),'b');
plot(t,xLQR(:,3),'g');
title('Velocity trajectory'); xlabel('Time (s)'); ylabel('Velocity (m/s)');
subplot(4,1,4); hold on;
plot(t,xLQG(:,5),'b');
plot(t,xLQR(:,4),'g');
title('Angular velocity trajectory'); xlabel('Time (s)'); ylabel('Angular velocity (rad/s)');
legend('LQG Trajectory','LQR Trajectory');

% Nyquist
figure;
nyquist(sysLQG(1));