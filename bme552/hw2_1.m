% Using the three element model, plots the impedance for various
% conditions.

clear; close all;

% In each case, plotting between 1 Hz and 100 kHz. Electrode impedance 7
% MOhm. Tissue resistivity 125 Ohm*cm.
% Capacitance per unit area 40e-6 uF/cm2 = .4F/m2
fstart = 1; fend = 100e3;
Relec = 7e6;
radius = 80e-6;
rhoTiss = 1.25; % = 125 Ohm*cm
rough = 1;
%------------------------------------------------------------------------
% a)
[Z f] = electrodeImpedance(Relec,rhoTiss,radius,rough,fstart,fend);

% Plot log modulus against log frequency.
figure;
subplot(2,1,1);
loglog(f,abs(Z));
title('Impedance modulus');
xlabel('log f'); ylabel('log |Z|');

% Plot angle against log frequency.
subplot(2,1,2);
semilogx(f, angle(Z));
title('Impedance phase');
xlabel('log f'); ylabel('phase'); 

%------------------------------------------------------------------------

% b) Radius changed to 50, 125, and 250 um.
figure;
radius = [50 125 250]*1e-6;
color = 'rgb';      % styles for graphs
for (i = 1:3)
    [Z f] = electrodeImpedance(Relec,rhoTiss,radius(i),rough,fstart,fend);
    subplot(2,1,1);
    loglog(f,abs(Z),color(i));
    hold on;
    title('Impedance modulus');
    xlabel('log f'); ylabel('log |Z|');

    % Plot angle against log frequency.
    subplot(2,1,2);
    semilogx(f, angle(Z), color(i));
    hold on;
    title('Impedance phase');
    xlabel('log f'); ylabel('phase'); 
end
legend('r = 50\mum','r = 125\mum','r = 250\mum');
 
%------------------------------------------------------------------------

% c) Roughness factor changed to 3.0 and 20 um.
figure;
radius = 80e-6;     % reset to initial
rough = [1 3 20];
color = 'rgb';      % styles for graphs
for (i = 1:3)
    [Z f] = electrodeImpedance(Relec,rhoTiss,radius,rough(i),fstart,fend);
    subplot(2,1,1);
    loglog(f,abs(Z),color(i));
    hold on;
    title('Impedance modulus');
    xlabel('log f'); ylabel('log |Z|');

    % Plot angle against log frequency.
    subplot(2,1,2);
    semilogx(f, angle(Z), color(i));
    hold on;
    title('Impedance phase');
    xlabel('log f'); ylabel('phase'); 
end
legend('rf = 1.0','rf = 3.0','rf = 20');

%------------------------------------------------------------------------

% d) Tissue resistivity changed to 50, 250 Ohm*cm = 0.5 and 2.5 Ohm*m.
figure;
rough = 1;
rhoTiss = [0.5 1.25 2.5];
color = 'rgb';      % styles for graphs
for (i = 1:3)
    [Z f] = electrodeImpedance(Relec,rhoTiss(i),radius,rough,fstart,fend);
    subplot(2,1,1);
    loglog(f,abs(Z),color(i));
    hold on;
    title('Impedance modulus');
    xlabel('log f'); ylabel('log |Z|');

    % Plot angle against log frequency.
    subplot(2,1,2);
    semilogx(f, angle(Z), color(i));
    hold on;
    title('Impedance phase');
    xlabel('log f'); ylabel('phase'); 
end
legend('resistivity = 50\Omega*cm','resistivity = 125\Omega*cm','resistivity = 250\Omega*cm');

% % Plot log modulus against log frequency.
%     figure;
%     subplot(1,2,1);
%     plot(log10(f), log10(abs(Z)));
%     title('Impedance modulus');
%     xlabel('log f'); ylabel('log |Z|');
%     
%     % Plot angle against log frequency.
%     subplot(1,2,2);
%     plot(log10(f), angle(Z));
%     title('Impedance phase');
%     xlabel('log f'); ylabel('phase'); 