clear; close all;
sys = tf([1000 1000],[1 20 103 40 100]);
figure('Name','(a)'); amnyquist(sys);
figure('Name','(a)'); bode(sys);
[Gm Pm] = margin(sys)
 
sys = tf([100 1000],[100 101 1]);
figure('Name','(b)'); amnyquist(sys);
figure('Name','(b)'); bode(sys);
[Gm Pm] = margin(sys)