% Simulates a voltage-clamp experiment where a "squid axon" is modeled
% by Hodgkin-Huxley parameters (Na, K, C, and leakage). Stimulus current is
% injected and the voltages, channel conductances/currents, and HH
% parameter responses are recorded. Simulates 30 ms pulse.
% Voltages in mV, times in ms, conductances in mS, capacitance in uF,
% currents in uA.
function V=project1()
    clear; close all;

    T = 35;         % Simulation total length (ms)
    pulseT = 30;   % Pulse duration (ms)
    dt = 0.01;      % Simulation time step (ms)
    gK_ = 36e-3;    % Unitary conductances, in mS
    gNa_= 120e-3;
    gL = 0.1e-3;
    E_K = -90;      % Reversal potentials (mV)
    E_Na = 55;
    E_L = -70;
    Cm = 2e-3;         % Capacitance in uF

    % Initialize vectors
    t = 0:dt:T;
    Ion = (.1:.05:.3)';            % Current at second step (uA)
    Ioff = zeros(length(Ion),1);    % Current when off.
    n = zeros(length(Ion),length(t));    % Keep track of rate coefficients
    m = zeros(length(Ion),length(t));
    h = zeros(length(Ion),length(t));
    I = zeros(length(Ion),length(t));
    I_K = zeros(length(Ion),length(t));  % Positive currents inward
    I_Na = zeros(length(Ion),length(t));
    I_L = zeros(length(Ion),length(t));
    I_C = zeros(length(Ion),length(t));

    % Calculate initial values of n, m, h.
    % Assumes V = 0 and has reached steady state.
    [an bn am bm ah bh] = calculateParams(-70);
    n(:,1) = an/(an+bn)*ones(size(Ion));
    m(:,1) = am/(am+bm)*ones(size(Ion));
    h(:,1) = ah/(ah+bh)*ones(size(Ion));
    V(:,1) = -70*ones(size(Ion));   % Assume -70 mV at start.
    for (i=1:(length(t)-1))
        % Decide value of V based on time.
        tt = (i-1)*dt;
        if (tt < 1 || tt > (1+pulseT))
            I(:,i) = Ioff;
        else
            I(:,i) = Ion;
        end
        
        % Calculate alpha and beta parameters.
        [an bn am bm ah bh] = calculateParams(V(:,i));
        n(:,i+1) = n(:,i) + (an.*(1-n(:,i))-bn.*n(:,i))*dt;
        m(:,i+1) = m(:,i) + (am.*(1-m(:,i))-bm.*m(:,i))*dt;
        h(:,i+1) = h(:,i) + (ah.*(1-h(:,i))-bh.*h(:,i))*dt;
        
        % Compute instantaneous conductances.
        gK = n(:,i).^4*gK_;
        gNa = m(:,i).^3.*h(:,i)*gNa_;
        
        % Compute instantaneous current.
        I_K(:,i) = gK.*(V(:,i) - E_K);
        I_Na(:,i) = gNa.*(V(:,i) - E_Na);
        I_L(:,i) = gL*(V(:,i)-E_L);
        
        % Compute next voltage value
        dV = dt*(I(:,i)-I_K(:,i)-I_Na(:,i)-I_L(:,i))/Cm;
        V(:,i+1) = V(:,i) + dV;
        
        I_C(:,i) = dV/dt*Cm;
    end
    I(:,length(t)) = Ioff;    % Since last value was never set.
    
    % Plot I
    subplot(2,1,1);
    plot(t,flipud(I));
    title('I'); xlabel('t (ms)'); ylabel('I (uA)');    
    
    % Plot V
    subplot(2,1,2);
    plot(t,V);
    title('V'); xlabel('t (ms)'); ylabel('V (mV)');
    legend('0.3 uA','0.25 uA','0.20 uA','0.15 uA','0.1 uA');
end

% Helper functions for evaluating alpha and beta values. Takes V (in mV)
% as input and returns parameters in the following order:
% [alpha_n, beta_n, alpha_m, beta_m, alpha_h, beta_h].
function [an bn am bm ah bh] = calculateParams(V)
    an = -.01*(V+60)./(exp(-(V+60)/10)-1);
    bn = .125*exp(-(V+70)/80);
    am = -.1*(V+45)./(exp(-(V+45)/10)-1);
    bm = 4*exp(-(V+70)/18);
    ah = .07*exp(-(V+70)/20);
    bh = 1./(exp(-(V+40)/10)+1);    
end