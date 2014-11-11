sys = tf([1 .1],[1 -1])*tf(1,[1 -1]); close all; ambode(sys); figure; step(sys/(1+sys)); figure; amnyquist(sys);


s1 = tf(100,[1 .2 1]);
ambode(s1)

ans =

  175.0267

cl = tf([1/(15/sqrt(6)) 1],[1/(15*sqrt(6)) 1]);
figure; ambode(s1*cl)

ans =

  375.0267

cl = tf([1/(12/sqrt(6)) 1],[1/(12*sqrt(6)) 1]);
figure; ambode(s1*cl)

ans =

  557.0057

cl = tf([1/(11/sqrt(6)) 1],[1/(11*sqrt(6)) 1]);
figure; ambode(s1*cl)

ans =

  739.0057

figure; ambode(s1*cl)

ans =

  375.0269

figure; bode(s1*cl)
close all
figure; bode(s1*cl)
C = 100*cl + tf(1,[1 0]);
P = tf(1,[1 .2 1]);
close all
figure; bode(P*C)
figure; bode(P*100*cl)
figure; bode(tf(1,[1 .2 0])*C)
C = 10*cl + tf(1,[1 0]);
close all
figure; bode(P*10*cl)
figure; bode(P*C)
figure; bode(tf(1,[1 .2 0])*C)
