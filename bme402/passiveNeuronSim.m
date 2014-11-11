% Simulates a passive neuron's response to different
% amplitude pulses, each of the same duration.
clear; close all;

Im = 1e-9*[-1.5:.5:1.5]';       % Current values in A.
Rm = 10e6;                      % Membrane resistance in Ohms * cm2.
Cm = 2e-9;                      % Membrane capacitance in F/cm2.
EL = -70e-3;                    % Leakage potential in V.
pulseT = 200;    % Pulse duration in ms.
startT = 10;     % Time when pulse starts.
endT = startT + pulseT;        % Time when pulse ends.
simT = startT + pulseT + 100;  % Total simulation time to be plotted

% Each row corresponds to the index of input Im,
V = EL*ones(7,simT+1); % For now, everything set to initial conditions.
                        % Simulation will overwrite later values.
I = zeros(7,simT+1);    % Current signal
dt = 1;

% Integration with forward Euler loop.
for (i = startT:dt:simT)    % Start at time 10 ms
    if (i < endT)   % Input current only nonzero between startT and endT.
        I(:,i) = Im;
    end
    % Each index is 1ms but for integration we convert back into seconds.
    dV = (I(:,i)/Cm - (V(:,i)-EL)/(Rm*Cm))*dt*.001;
    V(:,i+1) = V(:,i) + dV;
end
t = 0:dt:simT;

% Units conversion for better readibility.
I = I*1e9;  % For nA
V = V*1000; % For mV

% Current plot
subplot(2,1,1);
plot(t,I);
axis([0 300 -2 2]);
title('Current vs Time');
xlabel('Time (ms)');
ylabel('Current - inward negative, outward positive (nA)');

% Voltage plot
subplot(2,1,2);
plot(t,V);
axis([0 300 -90 -50]);
title('Membrane Potential vs Time');
xlabel('Time (ms)');
ylabel('Membrane Potential (mV)');
legend('I_m=-1.5nA','I_m=-1.0nA','I_m=-0.5nA','I_m=0.0nA','I_m=0.5nA','I_m=1.0nA','I_m=1.5nA');