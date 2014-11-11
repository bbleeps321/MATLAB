clear; close all;
J = .41; D = 1; tau = .01;
w = 10.^(-1:.01:3.5);
[num,den] = pade(tau,3);
delay = tf(num,den);
P = tf(1,[J D 0])*delay;

figure;
[mag,phase]=bode(P,w);
subplot(2,1,1); semilogx(w,20*log10(mag(1,:)),'r'); hold on;
title('Bode plot'); ylabel('Magnitude (dB)');
subplot(2,1,2); semilogx(w,phase(1,:),'r'); hold on;
ylabel('Phase'); xlabel('Frequency (rad/s)');

[mag,phase]=bode(60*P,w);
subplot(2,1,1); semilogx(w,20*log10(mag(1,:)),'g');
subplot(2,1,2); semilogx(w,phase(1,:),'g');

[Gm,Pm] = margin(60*P);
fprintf('Phase margin with 60*P(s) = %f\n',Pm);

a = 25/sqrt(4.5); b = 4.5*a;
C = tf(1,[1 1]) + tf(60,1)*tf([1/a 1],[1/b 1])^2;

[mag,phase]=bode(P*C,w);
subplot(2,1,1); semilogx(w,20*log10(mag(1,:)),'b');
subplot(2,1,2); semilogx(w,phase(1,:),'b');
legend('P(s)','60*P(s)','C(s)*P(s)');

[Gm,Pm] = margin(P*C);
fprintf('Final phase margin of P(s)*C(s) = %f\n',Pm);

closedLoop = P*C/(1+P*C);
figure; step(closedLoop);
info = stepinfo(P*C/(1+P*C));
fprintf('Overshoot of final closed loop = %f\n', info.Overshoot);

% figure; amnyquist(P*C,{w(1) w(end)});
figure; amnyquist(P*C);
% figure; subplot(2,1,1); semilogx(wn, re(1,:));
% subplot(2,1,2); semilogx(wn,im(1,:));
 
figure;
subplot(2,2,1); bode(1/(1+P*C)); title('1/(1+P*C)');
subplot(2,2,2); bode(P*C/(1+P*C)); title('P*C/(1+P*C)');
subplot(2,2,3); bode(P/(1+P*C)); title('P/(1+P*C)');
subplot(2,2,4); bode(C/(1+P*C)); title('C/(1+P*C)');