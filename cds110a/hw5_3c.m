clear; close all;
m = 1000; c = 50; b = 25; a = .2; T = 200;
kp = .5; ki = .1;
sysER = tf([1 a+c/m a*c/m 0],[1 a+c/m a*(c+kp*T*b)/m ki*a*T*b/m]);
sysYD = tf([1/m],[1 c/m]);
figure; step(sysER); title('Step response H_{er}');
figure; bode(sysER); title('H_{er}');
figure; step(sysYD); title('Step response H_{yd}');
figure; bode(sysYD); title('H_{yd}');