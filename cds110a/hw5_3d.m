clear; close all;
m = 1000; c = 50; b = 25; a = .2; T = 200;
kp = .5; ki = .1;
sysYR = tf([kp*a*T*b/m ki*a*T*b/m],[1 a+c/m a*(c+kp*T*b)/m ki*a*T*b/m]);
figure; step(sysYR); title('Step response H_{yr}');
figure; bode(sysYR); title('H_{yr}');