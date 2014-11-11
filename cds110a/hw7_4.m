clear; close all;
w = 10.^(-2:.01:4);
g = 9.8; m = 1.5; c = .05; l = .05; J = .0475; r = .25;
P = tf(r,[J c m*g*l]);
[mag,phase] = bode(P,w);

figure;
subplot(2,1,1); semilogx(w,20*log10(mag(1,:)),'r'); hold on;
title('Bode plot'); ylabel('Magnitude (dB)');
subplot(2,1,2); semilogx(w,phase(1,:),'r'); hold on;
ylabel('Phase');

C = tf(550*[1 2 1],[1 0]);
loop = P*C;
[mag,phase] = bode(loop,w);
subplot(2,1,1); semilogx(w,20*log10(mag(1,:)),'b');
subplot(2,1,2); semilogx(w,phase(1,:),'b');
legend('P(s)','P(s)*C(s)');
[Gm,Pm] = margin(loop)

closedLoop = P*C/(1+P*C);
figure; step(closedLoop);
figure; bode(closedLoop);
info = stepinfo(closedLoop);
Tr = info.RiseTime
Ts = info.SettlingTime
Overshoot = info.Overshoot