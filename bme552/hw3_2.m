% Estimates at what level above an electrode certain relationships
% between the center and edge of and electrode are met.
clear; close all;

a = 50e-6;  % radius
Vo = 1;
zmax = 1e-3;

r = 0:a/5000:a;
z = 0:zmax/5000:zmax;
V = zeros(length(r), length(z));

for (i = 1:length(r))
    for (j = 1:length(z))
        V(i,j) = 2*Vo/pi*asin(2*a/(sqrt((r(i)-a)^2+z(j)^2)+sqrt((r(i)+a)^2+z(j)^2)));
    end
end

E = abs(-gradient(V));
% mesh(r,z,E);

z = z*1e6;  % convert m to um

% Plot E above center
figure;
plot(z,E(1,:));

% Plot E above edge
hold on;
plot(z,E(end,:),'r');
legend('E above center', 'E above edge');
xlabel('z (\mum)'); ylabel('E (V/m)');
title('E Magnitude Above the Center and Edge of Electrode');

% Plot ratio of E above center to E above edge.
figure;
plot(z, E(1,:)./E(end,:));
title('Ratio of Electric Field Over Center to Edge of Electrode');
xlabel('z (\mum)'); ylabel('Ratio (center/edge)');

% Replotted with different axes ratio of E above center to E above edge.
figure;
plot(z, E(1,:)./E(end,:));
title('Ratio of Electric Field Over Center to Edge of Electrode');
xlabel('z (\mum)'); ylabel('Ratio (center/edge)');
axis([0 25 0 1])
