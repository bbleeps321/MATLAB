clear; close all;

M = 1; m = .1; g = 9.8; l = 1;
l0 = 1; % 1, .75, .5, min
w = 10.^(-1:.01:4);

% P = tf([(l-l0) 0 g],[M*l 0 (M+m)*g 0 0]); % down
P = tf([(l-l0) 0 -g],[M*l 0 -(M+m)*g 0 0]); % up



% pzmap, bode, gm, pm
figure;
[mag,phase]=bode(P,w);
subplot(2,1,1); semilogx(w,20*log10(mag(1,:)),'r'); hold on;
title('Bode plot'); ylabel('Magnitude (dB)');
subplot(2,1,2); semilogx(w,phase(1,:),'r'); hold on;
ylabel('Phase'); xlabel('Frequency (rad/s)');

[mag,phase]=bode(100*P,w);
subplot(2,1,1); semilogx(w,20*log10(mag(1,:)),'g');
subplot(2,1,2); semilogx(w,phase(1,:),'g');

a = 1.5/sqrt(6); b = 6*a;
% C = 1;

C1 = 1*tf([1/a 1],[1/b 1]);
% C = tf([1 1],[1/100 1])^2*tf(1,[1/100 1]); 
% C = .001*tf([1/a 1],[1/b 1])^2*tf([1/.1 1],[1/100 1])^2;

% C = tf([1 0 0],1)*tf([1/a 1],[1/b 1]);

% C = tf([1/a 1],[1/b 1])^2;

% C = tf([1/a2 1],[1/b2 1])*tf([1/a 1],[1/b 1])*tf(1,[1 0 0]);
% C = tf([1/a2 1],[1/b2 1])*tf([1/a 1],[1/b 1])*tf(1,[1 0 0]);


% C = 100*tf([1 a],[1 b]);
% C = 100*tf([1/a 1],[1/b 1])^5;
% C = tf([1/a 1],[1/b 1])*tf([1/a2 1],[1/b2 1])^4;

% C = tf([-5.247e4 -1.863e5 -5.466e4 -2.645e4],[1 75 1901 2e4 1.197e5]);

loop = P*C;
[mag,phase]=bode(loop,w);
subplot(2,1,1); semilogx(w,20*log10(mag(1,:)),'b');
subplot(2,1,2); semilogx(w,phase(1,:),'b');
legend('P(s)','100*P(s)','P(s)*C(s)');

[gm pm] = margin(loop)

closedLoop = P/(1+P*C);
figure; pzmap(closedLoop);
[p z] = pzmap(closedLoop)

figure; step(closedLoop);

% figure;
% subplot(2,2,1); bode(1/(1+P*C)); title('1/(1+PC)');
% subplot(2,2,2); bode(P*C/(1+P*C)); title('PC/(1+PC)');
% subplot(2,2,3); bode(P/(1+P*C)); title('P/(1+PC)');
% subplot(2,2,4); bode(C/(1+P*C)); title('C/(1+PC)');