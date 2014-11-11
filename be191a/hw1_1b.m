clear; close all;
k = 1; tf = 12;
x0 = [.5 .25 .6; .5 .75 .4; 0 0 0];
dxdt = @(t,x)[-k*x(1)*x(2)+k*x(1)*x(3);...
              -k*x(1)*x(2)+k*x(2)*x(3);...
              2*k*x(1)*x(2)-k*x(1)*x(3)-k*x(2)*x(3)];
col = 'rbg';
figure;
for (i=1:3)
    [t,y] = ode45(dxdt,[0 tf],x0(:,i));
    for (j=1:3)
        subplot(3,1,i);
        plot(t,y(:,j),col(j));
        hold on;
    end
    ylabel('Concentration (M)');
end
subplot(3,1,1); title('[X]_0 = [Y]_0 = .5M');
subplot(3,1,2); title('[X]_0 = .25nM < [Y]_0 = .75M');
subplot(3,1,3); title('[X]_0 = .6nM > [Y]_0 = .4M');
legend('[X]','[Y]','[Z]');
xlabel('Time (s)');
