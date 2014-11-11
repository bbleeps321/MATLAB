function sol = lbs_odes(I0,F0,tfinal)

% tfinal = 2; % Final time for simulation
species = {'sp_1','sp_2'}; % The list of all species
n = length(species);

% Assign initial conditions
x0 = zeros(n,1);
x0(1) = I0; % I
x0(2) = F0; % F

% Solve the ODEs
[t,x] = ode15s(@compute_odes,[0 tfinal],x0);

% Write out a solution structure to be returned by the function
sol.t = t;
for i = 1:n
  sol.(species{i}) = x(:,i);
end

% Produce a plot
% figure;
plot(t, x)
legend('I', 'F')

return

%%%

function dxdt = compute_odes(t,x)

% Assign derivatives
dx = zeros(2,1);


% Define reaction propensities
r_0 = 1*x(1)*x(2);

% Assign derivatives
dsp_1 = r_0;
dsp_2 = -r_0;


dxdt = [dsp_1; dsp_2];

return
