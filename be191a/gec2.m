function sol = lbs_odes(X0,Y0,X1,Y1,tfinal)

% tfinal = 1000; % Final time for simulation
species = {'sp_1','sp_2','sp_3','sp_4','sp_5','sp_6','sp_7','sp_8','sp_9','sp_10','sp_11','sp_12','sp_13','sp_14'}; % The list of all species
n = length(species);

% Assign initial conditions
x0 = zeros(n,1);
x0(1) = X0;
x0(2) = Y0;
x0(4) = Y1;
x0(6) = X1;
x0([9 10 13 14]) = 50;


% Solve the ODEs
[t,x] = ode15s(@compute_odes,[0 tfinal],x0);

% Write out a solution structure to be returned by the function
sol.t = t;
for i = 1:n
  sol.(species{i}) = x(:,i);
end

% Produce a plot
% figure;
if (nargout < 1)
    plot(t, x(:,[4 6 13]));
    legend('Y1', 'X1','Z1')
end
% legend('X0', 'Y0', 'xy00', 'Y1', 'xy01', 'X1', 'xy10', 'xy11', 'z0', 'z1', 'zz00', 'zz11', 'Z1', 'Z0')


return

%%%

function dxdt = compute_odes(t,x)

% Assign derivatives
dx = zeros(14,1);


% Define reaction propensities
r_0 = 1*x(1)*x(2);
r_1 = 1*x(1)*x(4);
r_2 = 1*x(6)*x(2);
r_3 = 1*x(6)*x(4);
r_4 = 1*x(3)*x(9);
r_5 = 1*x(5)*x(9);
r_6 = 1*x(7)*x(9);
r_7 = 1*x(8)*x(10);
r_8 = 1*(x(9)^2);
r_9 = 1*(x(10)^2);
r_10 = 1*x(11)*x(13);
r_11 = 1*x(12)*x(14);

% Assign derivatives
dsp_1 = -r_0 - r_1 + r_4 + r_5;
dsp_2 = -r_0 - r_2 + r_4 + r_6;
dsp_3 = r_0 - r_4;
dsp_4 = -r_1 - r_3 + r_5 + r_7;
dsp_5 = r_1 - r_5;
dsp_6 = -r_2 - r_3 + r_6 + r_7;
dsp_7 = r_2 - r_6;
dsp_8 = r_3 - r_7;
dsp_9 = -r_4 - r_5 - r_6 + r_7 - 2*r_8 + 2*r_10;
dsp_10 = r_4 + r_5 + r_6 - r_7 - 2*r_9 + 2*r_11;
dsp_11 = r_8 - r_10;
dsp_12 = r_9 - r_11;
dsp_13 = -r_10 + r_11;
dsp_14 = r_10 - r_11;


dxdt = [dsp_1; dsp_2; dsp_3; dsp_4; dsp_5; dsp_6; dsp_7; dsp_8; dsp_9; dsp_10; dsp_11; dsp_12; dsp_13; dsp_14];

return
