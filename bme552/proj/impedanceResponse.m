% Plots the impedance (magnitude and phase) given parameters to 
% the three element model for an electrode.
% All units in MKS standard.
% ex:
% impedanceResponse(7e6,0.4,1.25,80e-6,1,1,100e3)
% Rp = 7 MOhm, Cm = .4 F/m^2
% rho = 1.25 Ohm*cm = 2 Ohm*m, rough = 1, radius = 80 um,
% start freq = 1 Hz, end freq = 100 kHz.
function [Z f] = electrodeImpedance(Rp, Cm, rho, radius, rough, fstart, fend)
    A = pi*radius^2;
    C = Cm*A*rough;   % 40 uF/cm2 = 0.4 F/m^2
    Rtiss = rho/(4*radius);

    % Set up frequency range in w.
    logf = linspace(log10(fstart), log10(fend), 500);
    f = 10.^logf;
    w = 2*pi*f;
    
    % Model is Rp in parallel with C, all in series with Rtiss.
    % The equivalent impedance of that circuit is:
    Z = Rp./(1+j*w*Rp*C) + Rtiss;
end