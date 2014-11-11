clear; close all;

M = 1; m = .1; g = 9.8; l = 1;
l0 = 1; % 1, .75, .5, min
d = M+m-m*l;

% down
A = [0 0 1 0; 0 0 0 1; 0 -g*m*l/d 0 0; 0 -g*(M+m)/d 0 0];
B = [0; 0; 1/d; +1/d];
C = [1 -l0 0 0];
D = 0;

P = ss(A,B,C,D);
Wr = ctrb(A,B);
rank(Wr);
Wo = obsv(A,C);
rank(Wo);

K = place(A,B,[-2;-10;-.5+1i;-.5-1i]);
L = place(A',C',[-4;-20;-2+2i;-2-2i])';

CO = ss(A-B*K-L*C,L,K,0);

% closed = @(t,x) [A-B*K B*K; zeros(4) A-L*C]*x;
% [t,x] = ode45(closed,[0 10],[0 .1 0 .1 0 0 0 0]);
% figure; plot(t,x(:,1:2));

% closedLoop = ...
%     ss([A-B*K B*K; zeros(4) A-L*C],zeros(8,1),[0 1 0 0 0 0 0 0],0);
% figure; step(closedLoop);
% figure; pzmap(closedLoop);

loop = P*CO;
figure; bode(loop);
figure; pzmap(loop);
[Gm,Pm] = margin(loop)

closedLoop = P*CO/(1+P*CO);
figure; step(closedLoop);
figure; pzmap(closedLoop);