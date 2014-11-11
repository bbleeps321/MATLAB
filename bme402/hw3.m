% Simulates a voltage-clamp experiment where a "squid axon" is modeled
% by Hodgkin-Huxley parameters (Na and K only). Membrane potential is 
% stepped twice and both ovltages and currents are plotted.
% Voltages in mV, times in ms, conductances in mS, currents in uA
function hw3()
    clear; close all;

    T = 14;         % Simulation total length (ms)
    dt = 1e-3;
    gK_ = 36;       % Unitary conductances, in uS
    gNa_= 120;
    E_K = -70;      % Reversal potentials (mV)
    E_Na = 55;

    % Initialize vectors
    t = 0:dt:T;
    V2 = [-40:10:60];               % Voltage at second step (mV)
    V1 = -70*ones(length(V2),1);    % Voltage at first step and end (mV).
    n = zeros(length(V2),length(t));    % Keep track of rate coefficients
    m = zeros(length(V2),length(t));
    h = zeros(length(V2),length(t));
    V = zeros(length(V2),length(t));
    I_K = zeros(length(V2),length(t));  % Positive currents inward
    I_Na = zeros(length(V2),length(t));

    % Calculate initial values of n, m, h.
    % Assumes V = 0 and has reached steady state.
    [an bn am bm ah bh] = calculateParams(-70);
    n(:,1) = an/(an+bn)*ones(size(V2));
    m(:,1) = am/(am+bm)*ones(size(V2));
    h(:,1) = ah/(ah+bh)*ones(size(V2));
    for (i=1:(length(t)-1))
        % Decide value of V based on time.
        tt = (i-1)*dt;
        if (tt < 1 || tt > 9)
            V(:,i) = V1;
        else
            V(:,i) = V2;
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
    end
    V(:,length(t)) = V1;    % Since last value was never set.    
    
    % Convert from nA to uA
    I_K = 1e-3*I_K;
    I_Na = 1e-3*I_Na;
    
    subplot(4,1,1);
    plot(t,V);
    title('V'); xlabel('t (ms)'); ylabel('V (mV)');
    legend('-40 mV','-30 mV','-20 mV','-10 mV','0 mV','10 mV','20 mV','30 mV','40 mV','50 mV','60 mV');
    subplot(4,1,2);
    plot(t,I_K);
    title('Potassium Current'); xlabel('t (ms)');
    ylabel('Potassium Current (uA)');
    subplot(4,1,3);    
    plot(t,I_Na);
    title('Sodium Current'); xlabel('t (ms)');
    ylabel('Sodium Current (uA)');
    subplot(4,1,4);
    plot(t,I_K+I_Na);
    title('Total Current'); xlabel('t (ms)');
    ylabel('Total Current (uA)');
    
%     figure;
%     plot(t,n(1,:));
%     title('n');
%     figure;
%     plot(t,m(1,:));
%     hold on;
%     plot(t,h(1,:),'r');
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