clear; close all;

M = 1; m = .1; g = 9.8; l = 1;
l0 = .5; % 1, .75, .5, .4
d = M+m-m*l;

% up
A = [0 0 1 0; 0 0 0 1; 0 -g*m*l/d 0 0; 0 g*(M+m)/d 0 0];
B = [0; 0; 1/d; -1/d];
C = [1 l0 0 0];
D = 0;

P = ss(A,B,C,D);
Wr = ctrb(A,B);
rankWr = rank(Wr)
Wo = obsv(A,C);
rankWo = rank(Wo)

% K = place(A,B,[-20;-30;-10+10i;-10-10i]); % 1/.95
% L = place(A',C',[-24;-36;-12+12i;-12-12i])';
% K = place(A,B,[-10;-15;-5+5i;-5-5i]) % 1/.9
% L = place(A',C',[-15;-25;-7+7i;-7-7i])'
K = place(A,B,[-4;-6;-2+2i;-2-2i]) % 1/0.5
L = place(A',C',[-8;-12;-4+4i;-4-4i])'

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
[Gm,Pm] = margin(loop)

closedLoop = P*CO/(1+P*CO);
figure; step(closedLoop);
figure; pzmap(closedLoop);
[p z] = pzmap(closedLoop)