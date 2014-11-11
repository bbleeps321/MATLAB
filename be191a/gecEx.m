function sol = lbs_odes()

tfinal = 100; % Final time for simulation
species = {'sp_1','sp_2','sp_3'}; % The list of all species
n = length(species);

% Assign initial conditions
x0 = zeros(n,1);
x0(1) = 15;
x0(2) = 0.0005;

% Solve the ODEs
[t,x] = ode15s(@compute_odes,[0 tfinal],x0);

% Write out a solution structure to be returned by the function
sol.t = t;
for i = 1:n
  sol.(species{i}) = x(:,i);
end

% Produce a plot
figure;
plot(t, x(:,1))
legend('X');%ck, 'E', 'EX')

return

%%%

function dxdt = compute_odes(t,x)

% Assign derivatives
dx = zeros(3,1);


% Define reaction propensities
r_0 = 20*x(1);
r_1 = 1*(x(1)^2);
r_2 = 10000000*x(2)*x(1);
r_3 = 180000*x(3);

% Assign derivatives
dsp_1 = r_0 - r_1 - r_2;
dsp_2 = -r_2 + r_3;
dsp_3 = r_2 - r_3;


dxdt = [dsp_1; dsp_2; dsp_3];

return
