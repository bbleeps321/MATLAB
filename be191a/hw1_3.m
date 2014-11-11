% clear; close all;
x0 = [0 1 0]; tf = 50;
a = .2; b= .2; c = 5.7;
rossler = @(t,X) [-X(3)-X(2); X(1)+a*X(2); b+X(3)*(X(1)-c)];

% Plot (x,y,z)
[t,y]=ode23(rossler,0:tf/1000:tf,[0 1 0]);

figure;
plot(t,y);
title('Rossler Attracter'); xlabel('Time (s)'); ylabel('Value'); 
legend('x','y','z');
figure;
plot3(y(:,1),y(:,2),y(:,3));
title('Rossler Attracter'); xlabel('x'); ylabel('y'); zlabel('z');

sol = gec3(x0,tf);