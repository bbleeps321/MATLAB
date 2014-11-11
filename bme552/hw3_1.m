% Calculates and plots voltage response of electrode
% to various current conditions.
clear; close all;

% Initial conditions
radius = 50e-6;
rho = 2;    % 200 Ohm*cm
rough = 1;
Rp = 1e6;
pulseAmp = 200e-6;
pulseWidth = 2e-3;
[V I t] = electrodeVoltResponse(radius,rho,rough,Rp,pulseAmp,pulseWidth);
plotIPulseVResp(t*1e3,V,I*1e6,'b');  % t in ms, V in V, I in uA

% Diameters changed to 250, 400, and 800 um.
[V I t] = electrodeVoltResponse(125e-6,rho,rough,Rp,pulseAmp,pulseWidth);
figure; plotIPulseVResp(t*1e3,V,I*1e6,'b');  % t in ms, V in V, I in uA
hold on;
[V I t] = electrodeVoltResponse(200e-6,rho,rough,Rp,pulseAmp,pulseWidth);
plotIPulseVResp(t*1e3,V,I*1e6,'r');  % t in ms, V in V, I in uA
[V I t] = electrodeVoltResponse(400e-6,rho,rough,Rp,pulseAmp,pulseWidth);
plotIPulseVResp(t*1e3,V,I*1e6,'g');  % t in ms, V in V, I in uA
legend('d=250/mum','d=400/mum','d=800/mum');

% Redo all diameters with roughness changed to 10.
rough = 10;
[V I t] = electrodeVoltResponse(radius,rho,rough,Rp,pulseAmp,pulseWidth);
figure; plotIPulseVResp(t*1e3,V,I*1e6,'b');  % t in ms, V in V, I in uA
hold on;
[V I t] = electrodeVoltResponse(125e-6,rho,rough,Rp,pulseAmp,pulseWidth);
plotIPulseVResp(t*1e3,V,I*1e6,'r');  % t in ms, V in V, I in uA
[V I t] = electrodeVoltResponse(200e-6,rho,rough,Rp,pulseAmp,pulseWidth);
plotIPulseVResp(t*1e3,V,I*1e6,'g');  % t in ms, V in V, I in uA
[V I t] = electrodeVoltResponse(400e-6,rho,rough,Rp,pulseAmp,pulseWidth);
plotIPulseVResp(t*1e3,V,I*1e6,'k');  % t in ms, V in V, I in uA
legend('d=100/mum','d=250/mum','d=400/mum','d=800/mum');

% Redo all diameters with roughness changed to 10 and rho = 500 Ohm*cm
rho = 5;  % 500 Ohm*cm = 5 Ohm*m
[V I t] = electrodeVoltResponse(radius,rho,rough,Rp,pulseAmp,pulseWidth);
figure; plotIPulseVResp(t*1e3,V,I*1e6,'b');  % t in ms, V in V, I in uA
hold on;
[V I t] = electrodeVoltResponse(125e-6,rho,rough,Rp,pulseAmp,pulseWidth);
plotIPulseVResp(t*1e3,V,I*1e6,'r');  % t in ms, V in V, I in uA
[V I t] = electrodeVoltResponse(200e-6,rho,rough,Rp,pulseAmp,pulseWidth);
plotIPulseVResp(t*1e3,V,I*1e6,'g');  % t in ms, V in V, I in uA
[V I t] = electrodeVoltResponse(400e-6,rho,rough,Rp,pulseAmp,pulseWidth);
plotIPulseVResp(t*1e3,V,I*1e6,'k');  % t in ms, V in V, I in uA
legend('d=100/mum','d=250/mum','d=400/mum','d=800/mum');

% Test with initial conditions but roughness 10, and pulse width
% at 0.1 ms and 5 ms.
rho = 2;
[V I t] = electrodeVoltResponse(radius,rho,rough,Rp,pulseAmp,.1e-3);
figure; plotIPulseVResp(t*1e3,V,I*1e6,'k');  % t in ms, V in V, I in uA
[V I t] = electrodeVoltResponse(radius,rho,rough,Rp,pulseAmp,5e-3);
figure; plotIPulseVResp(t*1e3,V,I*1e6,'k');  % t in ms, V in V, I in uA