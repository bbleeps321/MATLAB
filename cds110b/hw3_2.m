clear; close all;
M = 10; m = 1; g = 9.8; l = 10; l0 = [1 .75 .5];
sigma = .01;
d = m-(M+m);

t = 0:0.01:100;
x0 = [0; pi/16; 0; 0];
v = normrnd(0,sigma,size(t));
w = normrnd(0,sigma,size(t));
for (i=1:length(l0))
    % up
    A = [0 0 1 0; 0 0 0 1; 0 -g*m/M 0 0; 0 -g*(M+m)/(M*l) 0 0];
    B = [0; 0; 1/M; 1/(M*l)];
    C = [1 -l0(i) 0 0];
    D = 0;

    plant = ss(A,[B B],C,D);
    plantObs = ss(A,B,eye(4),0);
    
    x = lsim(plantObs,zeros(size(t)),t,x0);
    [kalmf,L,P] = kalman(plant,sigma,sigma);
    xhat = lsim(kalmf(2:5,:),[C*x'+v; w]',t,x0);

    % Trajectories
    figure;
    subplot(4,1,1);
    plot(t,x(:,1),'b'); hold on;
    plot(t,xhat(:,1),'r');
    title('Position trajectory'); xlabel('Time (s)'); ylabel('Position (m)');
    subplot(4,1,2);
    plot(t,x(:,2),'b'); hold on;
    plot(t,xhat(:,2),'r');
    title('Angle trajectory'); xlabel('Time (s)'); ylabel('Angle (rad)');
    subplot(4,1,3);
    plot(t,x(:,3),'b'); hold on;
    plot(t,xhat(:,3),'r');
    title('Velocity trajectory'); xlabel('Time (s)'); ylabel('Velocity (m/s)');
    subplot(4,1,4);
    plot(t,x(:,4),'b'); hold on;
    plot(t,xhat(:,4),'r');
    title('Angular velocity trajectory'); xlabel('Time (s)'); ylabel('Angular velocity (rad/s)');
    legend('Actual trajectory','Estimated trajectory');

    mse(i,:) = arrayfun(@(i) norm(x(i,:)-xhat(i,:)),1:size(x,1));
end
% mse
figure;
plot(t,mse');
title('Mean Square Error at Each Time'); xlabel('Time (s)'); ylabel('Square error');
legend('l_0=1','l_0=.75','l_0=.5');
fprintf('Mean square error for l0=1: %f\n',mean(mse(1,:)));
fprintf('Mean square error for l0=.75: %f\n',mean(mse(2,:)));
fprintf('Mean square error for l0=.5: %f\n',mean(mse(3,:)));