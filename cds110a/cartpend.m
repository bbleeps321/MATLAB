%--------------------------------------------------------------------------
% CDS 110a HW #3, Cart-pendulum
% D. MacMynowski 10/10/10
%
% This script calls ode45, which solves the differential equation for 
% the inverted cart-pendulum
% 
% 
%--------------------------------------------------------------------------


tf = 10;                        % run simulation for tf seconds
theta0 = 0.1;
x0 = 0;
IC = [x0;theta0;0;0];           % initial condition

% parameters:
M = 10;
m = 80;
J = 100;
c = 0.1;
ell = 1;
gamma = 0.01;
g = 9.8;

% Set tolerances for ode45 solver
options = odeset('RelTol', 1e-4, 'AbsTol', [1e-5]);

f = 1;  % step input

% First plot out a simulation for a single sweeping frequency
[t, y] = ode45(@cartpend_model, [0 tf], IC, options, M, m, J, g, ell, c, gamma, f);