clear; close all;
bike_linmod;
v0 = 5; r = .002; tf = 5;
A = [0 0 1 0; 0 0 0 1; -M\[K0+K2*v0^2 C*v0]]
B = [0; 0; M\[0;1]];
OutputMatrix = [0 1 0 0];
options = odeset('RelTol', 1e-3, 'AbsTol', [1e-3]);

bike = @(t,x,K,kr) (A-B*K)*x + B*kr*r;

K = place(A,B,[-2;-10;-1+1i;-1-1i])
kr = inv(OutputMatrix*inv(A-B*K)*B)
[t, x] = ode45(bike,[0 tf],zeros(4,1),options,K,kr);
subplot(2,1,1); hold on; plot(t,x(:,2),'r');
xlabel('time'); ylabel('Steering angle \delta');
title('Bicycle system response to step-change reference 0.002rad');
subplot(2,1,2); hold on; plot(t,-K*x'+kr*r,'r');
xlabel('time'); ylabel('Torque');

K = place(A,B,[-2;-10;-2+2i;-2-2i])
kr = inv(OutputMatrix*inv(A-B*K)*B)
[t, x] = ode45(bike,[0 tf],zeros(4,1),options,K,kr);
subplot(2,1,1); plot(t,x(:,2),'g');
subplot(2,1,2); plot(t,-K*x'+kr*r,'g');

K = place(A,B,[-2;-10;-5+5i;-5-5i])
kr = inv(OutputMatrix*inv(A-B*K)*B)
[t, x] = ode45(bike,[0 tf],zeros(4,1),options,K,kr);
subplot(2,1,1); plot(t,x(:,2),'b');
subplot(2,1,2); plot(t,-K*x'+kr*r,'b');
legend('-1 \pm 1i','-2 \pm 2i', '-5 \pm 5i');