close all;

% Calculates the peak and resting potentials (in mV) from the
% concentrations listed in Table 7-1 of Kandel.
K = [20;400];
Na = [440;50];
Cl = [560;52];

% Resting potential has permeability ratios: 1.0:0.04:0.45.
restP = [1 .04 .45];
rest = ghk(K, Na, Cl, restP)

% Peak potential has permeability ratios: 1.0:20:0.45.
peakP = [1 20 .45];
peak = ghk(K, Na, Cl, peakP)

% Find sensitivities of potentials to each ion. We vary each ion 
% concentration by a small amount and recalculate the peak and resting
% potentials.

% We pick a range to perturb the extracelular concentrations of
% .999 and 1.001 of original concentrations.
delta = linspace(-10,10);
Kout = K(1)+delta;
Naout = Na(1)+delta;
Clout = Cl(1)+delta;

% Calculate and plot resting potential changes for each ion concentration.
% Rows indexed as follows: K, Na, Cl.
rest = ones(3,1);
for (i=1:length(delta))
    % Modify the first element to change the extracellular concentration.
    rest(1,i) = ghk([Kout(i) K(2)], Na, Cl, restP);
    rest(2,i) = ghk(K, [Naout(i) Na(2)], Cl, restP);
    rest(3,i) = ghk(K, Na, [Clout(i) Cl(2)], restP);
end
figure; hold on;
plot(delta, rest(1,:), 'k-');
plot(delta, rest(2,:), 'k--');
plot(delta, rest(3,:), 'k:');
title('Resting potential with changes in extracellular ion concentration');
xlabel('Change in concentration from original (mM)');
ylabel('Resting potential (mV)');
legend('K', 'Na', 'Cl');

% Calculate and plot peak potential changes for each ion concentration.
% Rows indexed as follows: K, Na, Cl.
peak = ones(3,1);
for (i=1:length(delta))
    % Modify the first element to change the extracellular concentration.
    peak(1,i) = ghk([Kout(i) K(2)], Na, Cl, peakP);
    peak(2,i) = ghk(K, [Naout(i) Na(2)], Cl, peakP);
    peak(3,i) = ghk(K, Na, [Clout(i) Cl(2)], peakP);
end
figure; hold on;
plot(delta, peak(1,:), 'k-');
plot(delta, peak(2,:), 'k--');
plot(delta, peak(3,:), 'k:');
title('Peak potential with changes in extracellular ion concentration');
xlabel('Change in concentration from original (mM)');
ylabel('Peak potential (mV)');
legend('K', 'Na', 'Cl');

%     rest(1,i) = ghk([K(1)*delta K(2)], Na, Cl, restP);
%     rest(2,i) = ghk(K, [Na(1)*delta Na(2)], Cl, restP);
%     rest(3,i) = ghk(K, Na, [Cl(1)*delta Cl(2)], restP);
