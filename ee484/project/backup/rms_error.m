% Calculates RMS position error for ATT and T-Mobile towers around
% USC campus. All distances in meters.
clear; close all;


% Region to plot over.
latitude = deg2rad(linspace(34.0181405,34.0255262,100));
longitude = deg2rad(linspace(-118.2915947,-118.282459,100));
altitude = 56;  % average on campus
                % http://weather.gladstonefamily.net/site/KCQT
                
% Pick an origin at Exposition and Vermont.
[originN originE] = ell2utm(latitude(1),longitude(1));
[North East] = ell2utm(latitude, longitude);
plot(North,East);

% ATT Towers, in latitude, longitude, altitude.
towersAtt = deg2rad([32.020555 34.0189444 34.0277777;...
                     -118.290555 -118.299944 -118.260138]);
% Tower altitude from top of tower, convert from ft to m.
towerAltitude = [(171+199) (162+19) (222+62)]*.3048;
towersAtt = [towersAtt; towerAltitude];
rmsAtt = rmsGrid(North,East,altitude,towersAtt);

% Shift releative to origin
North = North - originN;
East = East - originE;

% Plot
figure;
set(gcf(), 'Renderer', 'painters')
mesh(North,East,rmsAtt);
% a = [min(x) max(x) min(y) max(y) min(min(rmsAtt))-1 max(max(rmsAtt))+1]
% axis([min(x) max(x) min(z) max(z) min(min(rmsAtt)) max(max(rmsAtt))]);
title('RMS Position Error for AT&T');
xlabel('North (m)');
ylabel('East (m)');
zlabel('RMS Position Error');
% figure;
% plot(x,rmsAtt(:,1));
