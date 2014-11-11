clear; close all;
M = 10; m = 1; g = 9.8; l = 10; l0 = [1];% .75 .5];
var = .01; sigma = sqrt(var);
d = m-(M+m);

t = [0:0.01:100]';
x0 = [0; pi/16; 0; 0];
v = normrnd(0,sigma,size(t));
w = normrnd(0,sigma,size(t));
for (i=1:length(l0))
    % up
    A = [0 0 1 0; 0 0 0 1; 0 -g*m/M 0 0; 0 -g*(M+m)/(M*l) 0 0];
    B = [0; 0; 1/M; 1/(M*l)];
    C = [1 -l0(i) 0 0];
    D = 0;

    plant = ss(A,[B B],C,D,...
        'statename',{'x' 'theta' 'xdot' 'thetadot'},'inputname',{'u' 'w'},'outputname','y');
    plantObs = ss(A,B,eye(4),0);    
    x = lsim(plantObs,zeros(size(t)),t,x0);
    
    [kalmf,L] = kalman(plant,var,var);
    P = ss(A,[B B 0*B],[C;eye(4)],[0 0 1; zeros(4,3)],...
        'inputname',{'u' 'w' 'v'},...
        'outputname',{'yv' 'x' 'theta' 'xdot' 'thetadot'});
    sys = parallel(P,kalmf,1,1,[],[]);
    SimModel = feedback(sys,1,4,1,1);
%     SimModel = series(sys,1,4);
    
    xhat = lsim(SimModel,[zeros(size(t)) w v zeros(size(t))],t,[x0; zeros(4,1)]);
    
    % Trajectories
    figure;
    subplot(4,1,1);
    plot(t,xhat(:,2),'g'); hold on;
    plot(t,xhat(:,7),'b');
    title('Position trajectory'); xlabel('Time (s)'); ylabel('Position (m)');
    subplot(4,1,2);
    plot(t,xhat(:,3),'g'); hold on;
    plot(t,xhat(:,8),'b');
    title('Angle trajectory'); xlabel('Time (s)'); ylabel('Angle (rad)');
    subplot(4,1,3);
    plot(t,xhat(:,4),'g'); hold on;
    plot(t,xhat(:,9),'b');
    title('Velocity trajectory'); xlabel('Time (s)'); ylabel('Velocity (m/s)');
    subplot(4,1,4);
    plot(t,xhat(:,5),'g'); hold on;
    plot(t,xhat(:,10),'b');
    title('Angular velocity trajectory'); xlabel('Time (s)'); ylabel('Angular velocity (rad/s)');
%     legend('Actual trajectory','Estimated trajectory');

%     mse(i) = mean(arrayfun(@(i) norm(x(i,:)-xhat(i,:)),1:size(x,1)));
%     mse(i,:) = arrayfun(@(i) norm(x(i,:)-xhat(i,:)),1:size(x,1));
end
% mse
% figure;
% plot(t,mse');
% title('Mean Square Error'); xlabel('Time (s)'); ylabel('Square error');
% norm(mse(1,:))
% norm(mse(2,:))
% norm(mse(3,:))
