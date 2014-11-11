function sol = lbs_odes(xinit,tfinal)

% tfinal = 25; % Final time for simulation
species = {'sp_1','sp_2','sp_3','sp_4','sp_5','sp_6','sp_7','sp_8','sp_9','sp_10','sp_11'}; % The list of all species
n = length(species);

global Etot;
global a;
global b;
global c;
global m;
m = 20;
Etot = m/100;
a = .2;
b = .2;
c = 5.7;

% Assign initial conditions
x0 = zeros(n,1);
x0(1) = m+xinit(1);
x0(2) = Etot;
x0(4) = m+xinit(2);
x0(5) = Etot;
x0(7) = m+xinit(3);
x0(8) = Etot;
x0(10) = Etot;
% x0(1) = 30;cl
% x0(2) = .05;
% x0(4) = 31;
% x0(5) = .05;
% x0(7) = 30;
% x0(8) = .05;
% x0(10) = .05;

% Solve the ODEs
% options = odeset('RelTol',1e-2,'AbsTol',[1e-2]);
[t,x] = ode15s(@compute_odes,0:tfinal/1000:tfinal,x0);

% Write out a solution structure to be returned by the function
sol.t = t;
for i = 1:n
  sol.(species{i}) = x(:,i);
end

% Produce a plot
figure;
x = sol.sp_1;
y = sol.sp_4;
z = sol.sp_7;
plot(sol.t, [x, y, z]);
xlabel('Time (s)'); ylabel('Concentration (nM)');
legend('[X]', '[Y]', '[Z]');
title('CRN Rossler Attractor');
% plot(sol.t, [sol.sp_1 sol.sp_2 sol.sp_3 sol.sp_4 sol.sp_5 sol.sp_6 ...
%     sol.sp_7 sol.sp_8 sol.sp_9 sol.sp_10 sol.sp_11]);


% legend('X','D1','D1X','Y','D2','D2X','Z','E1','E1Y','D3','D3Z');
% 
% figure;
% subplot(11,1,1); plot(sol.t,sol.sp_1); title('X');
% subplot(11,1,2); plot(sol.t,sol.sp_2); title('D1');
% subplot(11,1,3); plot(sol.t,sol.sp_3); title('D1X');
% subplot(11,1,4); plot(sol.t,sol.sp_4); title('Y');
% subplot(11,1,5); plot(sol.t,sol.sp_5); title('D2');
% subplot(11,1,6); plot(sol.t,sol.sp_6); title('D2X');
% subplot(11,1,7); plot(sol.t,sol.sp_7); title('Z');
% subplot(11,1,8); plot(sol.t,sol.sp_8); title('E1');
% subplot(11,1,9); plot(sol.t,sol.sp_9); title('E1Y');
% subplot(11,1,10); plot(sol.t,sol.sp_10); title('D3');
% subplot(11,1,11); plot(sol.t,sol.sp_11); title('D3Z');

figure;
plot3(x,y,z);
xlabel('[X]'); ylabel('[Y]'); zlabel('[Z]');
title('CRN Rossler Attractor');

return

%%%

function dxdt = compute_odes(t,x)

kf = 100000;
global Etot;
global a;
global b;
global c;
global m;

% Assign derivatives
dx = zeros(11,1);


% Define reaction propensities
r_0 = 2*m;
r_1 = kf*x(2)*x(1);
r_2 = 1/Etot*x(3)*x(4);
r_3 = kf*x(5)*x(1);
r_4 = 1/Etot*x(6)*x(7);
r_5 = a*x(4);
r_6 = 1*x(1);
r_7 = kf*x(8)*x(4);
r_8 = m*(1+a)/Etot*x(9);
r_9 = (m+c)*x(7);
r_10 = m*(m+c)+b;
r_11 = 1*x(1)*x(7);
r_12 = kf*x(10)*x(7);
r_13 = m/Etot*x(11)*x(1);

% r_0 = 60;
% r_1 = 1000*x(2)*x(1);
% r_2 = 20*x(3)*x(4);
% r_3 = 1000*x(5)*x(1);
% r_4 = 20*x(6)*x(7);
% r_5 = 0.2*x(4);
% r_6 = 1*x(1);
% r_7 = 1000*x(8)*x(4);
% r_8 = 720*x(9);
% r_9 = 35.7*x(7);
% r_10 = 1071;
% r_11 = 1*x(1)*x(7);
% r_12 = 1000*x(10)*x(7);
% r_13 = 600*x(11)*x(1);

% Assign derivatives
dsp_1 = r_0 - r_1 - r_3;% - r_6;
dsp_2 = -r_1 + r_2;
dsp_3 = r_1 - r_2;
dsp_4 = r_5 + r_6 - r_7;
dsp_5 = -r_3 + r_4;
dsp_6 = r_3 - r_4;
dsp_7 = -r_9 + r_10 + r_11 - r_12;
dsp_8 = -r_7 + r_8;
dsp_9 = r_7 - r_8;
dsp_10 = -r_12 + r_13;
dsp_11 = r_12 - r_13;


dxdt = [dsp_1; dsp_2; dsp_3; dsp_4; dsp_5; dsp_6; dsp_7; dsp_8; dsp_9; dsp_10; dsp_11];

return
