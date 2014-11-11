% Calculates RMS position error for ATT and T-Mobile towers around
% USC campus. All distances in meters.
% Uses ToolBox: http://www.mathworks.com/matlabcentral/fileexchange/15285
clear; close all;

% Region to plot over.
latitude = deg2rad(linspace(34.0181405,34.0255262,100));
longitude = deg2rad(linspace(-118.2915947,-118.282459,100));
                
% Pick an origin at Exposition and Vermont.
[originN originE] = ell2utm(latitude(1),longitude(1));
[North East] = ell2utm(latitude, longitude);

% ATT Towers, in latitude, longitude, altitude.
towersAtt = deg2rad([34.020555 34.0189444 34.0277777;...
                     -118.290555 -118.299944 -118.260138]);

rmsAtt = rmsGrid(North,East,towersAtt);

% TMobile Towers
towersTM = deg2rad([34.04055 34.03921;
                    -118.28434 -118.29695]);
rmsTM = rmsGrid(North,East,towersTM);

% Shift releative to origin
North = North - originN;
East = East - originE;

% Plot
figure;
set(gcf(), 'Renderer', 'painters')
mesh(East,North,rmsAtt);
axis([min(East) max(East) min(North) max(North) min(min(rmsAtt)) max(max(rmsAtt))]);
title('RMS Position Error for AT&T');
ylabel('North (m)');
xlabel('East (m)');
zlabel('RMS Position Error');

figure;
set(gcf(), 'Renderer', 'painters')
mesh(East,North,rmsTM);
axis([min(East) max(East) min(North) max(North) min(min(rmsTM)) max(max(rmsTM))]);
title('RMS Position Error for T-Mobile');
ylabel('North (m)');
xlabel('East (m)');
zlabel('RMS Position Error');