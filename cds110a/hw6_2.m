close all; clear;
b = 25; T = 200; a = .2; m = 1000; c = 50;
kp = [.5 .05 .05 .005];
ki = [.1 1 .001 .001];
P = tf([T*b*a/m],[1 a+c/m a*c/m]);
for (i = 1:4)
    C = tf([kp(i) ki(i)],[1 0]);
    closedSys = P*C/(1+P*C);
    loop = P*C;
    figure; pzmap(closedSys);
    title(sprintf('Pole-Zero Map: kp = %f, ki = %f',kp(i),ki(i)));
    figure; [Y,TT]=step(closedSys); plot(TT,Y); grid on;
    title(sprintf('Step Response: kp = %f, ki = %f',kp(i),ki(i)));
    figure; bode(loop); grid on;
    title(sprintf('Bode Plot: kp = %f, ki = %f',kp(i),ki(i)));
    BW = bandwidth(closedSys);
    [Gm,Pm]=margin(loop);
    S = stepinfo(Y,TT);
    fprintf('kp=%f, ki=%f: BW=%f, Gm=%f, Pm=%f\n\tTr=%f, Mp=%f\n',...
        kp(i),ki(i),BW,Gm,Pm,S.RiseTime,S.Overshoot);
end