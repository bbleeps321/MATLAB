clear; close all;
w = 10.^(-2:.01:4);
P = tf([1.5 .75],[1 .7 .05]);
figure; pzmap(P);
[mag,phase] = bode(P,w);

figure;
subplot(2,1,1); semilogx(w,20*log10(mag(1,:)),'r'); hold on;
title('Bode plot'); ylabel('Magnitude (dB)');
subplot(2,1,2); semilogx(w,phase(1,:),'r'); hold on;
ylabel('Phase');

C = tf(20,1);

loop = P*C;
[mag,phase] = bode(loop,w);
subplot(2,1,1); semilogx(w,20*log10(mag(1,:)),'b');
subplot(2,1,2); semilogx(w,phase(1,:),'b');
legend('P(s)','P(s)*C(s)')
[Gm,Pm] = margin(loop)
dcgain = mag(1)

closedLoop = P*C/(1+P*C);
figure; step(closedLoop);
figure; bode(closedLoop);
figure; pzmap(closedLoop);