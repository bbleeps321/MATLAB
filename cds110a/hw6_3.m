close all; clear;
b = 25; T = 200; a = .2; m = 1000; c = 50;
kp = .05; ki = .001;
tau = [.25 .75];
P = tf([T*b*a/m],[1 a+c/m a*c/m]);
C = tf([kp ki],[1 0]);
for (i=1:2)
    G = tf([tau(i)^2/12 -tau(i)/2 1],[tau(i)^2/12 tau(i)/2 1]);
    closedSys = P*C/(1+P*C*G);
    loop = P*C*G;
    figure; [Y,TT]=step(closedSys); plot(TT,Y); grid on;
    title('Step Response');
    figure; bode(loop); grid on;
    title('Bode Plot');
    
    [Gm,Pm]=margin(loop);
    S = stepinfo(Y,TT);
    fprintf('tau=%f: Gm=%f, Pm=%f, Tr=%f, Ts=%f\n',...
        tau(i),Gm,Pm,S.RiseTime,S.SettlingTime);
end