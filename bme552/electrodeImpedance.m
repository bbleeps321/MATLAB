% Plots the impedance (magnitude and phase) given parameters to 
% the three element model for an electrode.
% All units in MKS standard.
function [Z f] = electrodeImpedance(Relec, rhoTiss, radius, rough, fstart, fend)
    A = pi*radius^2;
    C = .4*A*rough;   % 40 uF/cm2 = 0.4 F/m^2
    Rtiss = rhoTiss/(4*radius);

    % Set up frequency range in w.
    logf = linspace(log10(fstart), log10(fend), 500);
    f = 10.^logf;
    w = 2*pi*f;
    
    % Model is Relec in parallel with C, all in series with Rtiss.
    % The equivalent impedance of that circuit is:
    Z = Relec./(1+j*w*Relec*C) + Rtiss;
end

% Could also use this to plot:
% B = [Relec*Rtiss*C (Relec+Rtiss)];
% A = [Relec*C 1];
% freqs(B,A,2*pi*f);