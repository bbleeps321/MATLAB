clear; close all;
k = 4000; r = 25;
w = 10.^(-1:.001:4);
P = tf(k,[1 0 -r^2]);

figure;
[mag,phase]=bode(P,w);
subplot(2,1,1); semilogx(w,20*log10(mag(1,:)),'r'); hold on;
title('Bode plot'); ylabel('Magnitude (dB)');
subplot(2,1,2); semilogx(w,phase(1,:),'r'); hold on;
ylabel('Phase'); xlabel('Frequency (rad/s)');

a = 100/sqrt(6); b = 6*a;
C = tf([1/a 1],[1/b 1]);

loop = P*C;
[mag,phase]=bode(loop,w);
subplot(2,1,1); semilogx(w,20*log10(mag(1,:)),'b');
subplot(2,1,2); semilogx(w,phase(1,:),'b');
legend('P(s)','P(s)*C(s)');
[poles,zeros] = pzmap(loop)

closedLoop = P*C/(1+P*C);
[poles,zeros] = pzmap(closedLoop)

S = 1/(1+P*C);
w = 0:1:10^7;
[mag,phase] = bode(S,w);
figure; plot(w(1:10^3),log(mag(1,1:10^3)));
title('Sensitivity Plot'); xlabel('Frequency (rad/s)');
integral = trapz(w,log(mag(1,:)))


% figure;
% subplot(2,2,1); bode(1/(1+P*C)); title('1/(1+P*C)');
% subplot(2,2,2); bode(P*C/(1+P*C)); title('P*C/(1+P*C)');
% subplot(2,2,3); bode(P/(1+P*C)); title('P/(1+P*C)');
% subplot(2,2,4); bode(C/(1+P*C)); title('C/(1+P*C)');
% figure;
% subplot(2,2,1); pzmap(1/(1+P*C)); title('1/(1+P*C)');
% subplot(2,2,2); pzmap(P*C/(1+P*C)); title('P*C/(1+P*C)');
% subplot(2,2,3); pzmap(P/(1+P*C)); title('P/(1+P*C)');
% subplot(2,2,4); pzmap(C/(1+P*C)); title('C/(1+P*C)');