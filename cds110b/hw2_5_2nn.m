clear; close all;
M = 1; m = .1; g = 9.8; l = 1;
d = m-(M+m);

% up
A = [0 0 1 0; 0 0 0 1; 0 -g*m/M 0 0; 0 g*(M+m)/(M*l) 0 0];
B = [0; 0; 1/M; -1/(M*l)];
% C = eye(4);
D = 0;

% ssR = ss(pi/16*tf(pi,[1 0 pi^2]));
ssR = ss([0 pi/10; -pi/10 0],[0;0],[1 0],0);

% (a)
Aa = [A zeros(4,2); zeros(2,6)];
Ba = [B; 0; 0];
%Ca = [C zeros(4); ...
Ca = [0 1 0 0 -1 0; 0 0 0 1 0 -1]; 
Aa(5,5) = ssR.a(1,1);
Aa(5,6) = ssR.a(1,2);
Aa(6,5) = ssR.a(2,1);
Aa(6,6) = ssR.a(2,2);

% (b)
% Arb = zeros(4);
% Arb(1,1) = ssR.a(1,1);
% Arb(1,3) = ssR.a(1,2);
% Arb(3,1) = ssR.a(2,1);
% Arb(3,3) = ssR.a(2,2);


sysA = ss(Aa,Ba,Ca,D);
% sysB = ss(A-Arb,B,C,D);

R = 1;
Q = Ca'*Ca;

[Ka,Pa] = lqr(sysA,Q,R);
% [Kb,Pb] = lqr(sysB,Q,R);

sysCa = ss(Aa-B*Ka,Ba,Ca,D);
% sysCb = ss(A-Arb-B*Kb,B,C,D);

t = 0:0.01:25;
x0 = .5*ones(4,1);
yA = lsim(sysCa,ones(1,length(t)),t,x0);
% yB = lsim(sysCb,ones(1,length(t)),t,x0);
% yd = lsim(ssR,zeros(1,length(t)),t,[0;pi/16]);

% Errors
figure;
% (a)
subplot(2,1,1); plot(t,yA(:,5)); xlabel('Time'); ylabel('Cart position error');
title('Oscillating angle: error');
subplot(2,1,2); plot(t,yA(:,6)); xlabel('Time'); ylabel('Angle error');
% (b)
% figure;
% subplot(2,1,1); plot(t,yB(:,1)); xlabel('Time'); ylabel('Cart position error');
% title('Oscillating cart position: error');
% subplot(2,1,2); plot(t,yB(:,2)); xlabel('Time'); ylabel('Angle error');

% Actual cart position and angle plots
figure;
% (a)
subplot(2,1,1); plot(t,yA(:,1)); xlabel('Time'); ylabel('Cart position');
title('Oscillating angle');
subplot(2,1,2); plot(t,yA(:,2)); xlabel('Time'); ylabel('Angle');
% (b)
% figure;
% subplot(2,1,1); plot(t,yB(:,1)+yd(:,1)); xlabel('Time'); ylabel('Cart position');
% title('Oscillating cart position');
% subplot(2,1,2); plot(t,yB(:,2)); xlabel('Time'); ylabel('Angle');

% Control Effort
% Va = yA*Pa*yA';
% Vb = yB*Pb*yB';
figure; plot(t,-Ka*yA'); title('Control Effort over Time'); xlabel('Time'); ylabel('Control Effort (Cost)');
% figure; plot(t,-Kb*yB'); title('Control Effort over Time'); xlabel('Time'); ylabel('Control Effort (Cost)');



% t = 0:0.01:10;
% r = pi/16*sin(pi*t);
% [y,t,x]=lsim(sysc,r,t);
% [AX,H1,H2] = plotyy(t,y(:,1),t,y(:,2),'plot');
% set(get(AX(1),'Ylabel'),'String','cart position (m)')
% set(get(AX(2),'Ylabel'),'String','pendulum angle (radians)')
% title('Step Response with LQR Control')