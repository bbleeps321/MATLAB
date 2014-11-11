% Simulates alcohol concentration in the body
% for a male or female (set based on boolean flag).
% X is a matrix where column 1 is the data for x1,
% column 2 is the data for x2, etc. Units in grams.
% BAC is in units of %.
function [t x BAC] = alcohol_sim(dose, male, t0, tf)
    if (male)
        % Male parameters
        V = 40; ks = 10; a = 3e-5; ka = 13000; Vm = 55; Km = 50;
    else
        % Female parameters
        V = 30; ks = 10; a = 3e-5; ka = 13000; Vm = 45; Km = 50;
    end
    
    % Prepare to call ode45
    x0 = [dose; 0; 0];
    options = odeset('RelTol',1e-5,'AbsTol',1e-5);
    
    % Simulate
    [t x] = ode45(@f, [t0 tf], x0, options, ks, a, ka, Vm, Km);
    BAC = x(:,3)/(10*V);
end

% Takes in param struct p
function dxdt = f(t,x,ks,a,ka,Vm,Km)
    dxdt(1,1) = -ks*x(1)/(1+a*x(1)^2);
    dxdt(2,1) = ks*x(1)/(1+a*x(1)^2) - ka*x(2);
    dxdt(3,1) = ka*x(2) - Vm*x(3)/(Km+x(3));
end