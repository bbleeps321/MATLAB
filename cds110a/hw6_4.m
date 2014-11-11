clear; close all;
sys = tf(1,[1 4 -5 0]);
figure; amnyquist(sys);
figure; pzmap(sys);
figure; bode(sys);
figure; step(sys);