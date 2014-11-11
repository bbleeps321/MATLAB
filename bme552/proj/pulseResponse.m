% Takes in parameters for electrode and current pulse to simulate with.
% Plots pulse and results in a single figure.
% All units in MKS.
% ex:
% pulseResponse(1e6,.4,2,50e-6,1,1e-3,3e-3,200e-6)
% Rp = 1 MOhm, Cm = 0.4 F/m2
% rho = 200 Ohm*cm = 2 Ohm*m, rough = 1, radius = 50 um,
% pulse start = 1ms, pulse width = 3 ms, pulse amplitude 200 uA
function [V I t] = pulseResponse(Rp, Cm, rho, radius, rough, t0, T, pulseAmp, tend)
    A = pi*radius^2;
    C = Cm*A*rough; % 40 uF/cm2 = 0.4 F/m^2
    Rtiss = rho/(4*radius);
    
%     tend = t0+5*T;
    dt = tend/20000;
    t = 0:dt:tend;  % Simulate for 20 ms
    I = zeros(1,length(t));
    V = zeros(1,length(t));
    for (i = 1:(length(t)-1))
        tt = dt*(i-1);
        % Pulse only on until pulsewidth time up.
        if (t0 < tt && tt < (t0+T))
            I(i) = pulseAmp;
        end
        
        V(i+1) = V(i) + (I(i)/C - V(i)/(Rp*C))*dt;
    end
    
    % The V we've computed so far is only the V across the parallel
    % elements. We have to add in the V from the tissue resistance.
    V = V + I*Rtiss;
    
%     plotIPulseVResp(t*1e3,V,I*1e6,'k');
end