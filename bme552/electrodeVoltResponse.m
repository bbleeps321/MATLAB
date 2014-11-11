% Simulates the voltage response to a current pulse.
% Radius in meters, rho in Ohm*m, Rp in Ohm, pulseAmp in A,
% pulseWidth in seconds.
function [V I t] = electrodeVoltResponse(radius, rho, rough, Rp, pulseAmp, pulseWidth)
    A = pi*radius^2;
    C = .4*A*rough; % 40 uF/cm2 = 0.4 F/m^2
    Rtiss = rho/(4*radius);
    
    dt = 1e-6;
    startIndex = 1000; % Start pulse at 1 ms.
    t = 0:dt:20e-3;  % Simulate for 20 ms
    I = zeros(1,length(t));
    V = zeros(1,length(t));
    for (i = startIndex:(length(t)-1))  % Offset pulse start time for better graphing
        % Pulse only on until pulsewidth time up.
        if ((i-1-startIndex)*dt < pulseWidth)
            I(i) = pulseAmp;
        end
        
        V(i+1) = V(i) + (I(i)/C - V(i)/(Rp*C))*dt;
    end
    
    % The V we've computed so far is only the V across the parallel
    % elements. We have to add in the V from the tissue resistance.
    V = V + I*Rtiss;
end
