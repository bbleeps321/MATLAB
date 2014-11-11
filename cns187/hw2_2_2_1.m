close all;

%% Varying C
C = 1; R = 10;
I = [50 41 30 20 13 10 8 7 6 5 4 3 2 1];
spikes = [14 14 12 10 9 8 7 6 5 4 3 2 0 0];
time = 75e-3;

figure(2); subplot(1,2,1); hold on;
plot(I,spikes/time,'r');
subplot(1,2,2); hold on;
plot(I,spikes/time,'r');

C = 10; R = 10;
I = [30 20 13 10 7 1];
spikes = [4 3 2 1 0 0];
subplot(1,2,1);
plot(I,spikes/time,'g');

C = .1; R = 10;
I = [30 5 4.1 4 1];
spikes = [14 14 14 0 0];
subplot(1,2,1);
plot(I,spikes/time,'b');

xlabel('Current magnitude (nA)');
ylabel('Firing rate (spikes/sec)');
title('Firing rate vs Input current for different Capacitances');
axis([0 30 0 15/time]);
legend('C = 1F','C = 10F','C = 0.1F');

%% Varying R
C = 1; R = 1;
I = [50 41 40 1];
spikes = [14 14 0 0];
subplot(1,2,2);
plot(I,spikes/time,'g');

C = 1; R = 100;
I = [50 30 20 10 8 5 3 1];
spikes = [14 12 10 8 7 6 4 1];
subplot(1,2,2);
plot(I,spikes/time,'b');

xlabel('Current magnitude (nA)');
ylabel('Firing rate (spikes/sec)');
title('Firing rate vs Input current for different Resistances');
axis([0 50 0 15/time]);
legend('R = 10n\Omega','R = 1n\Omega','R = 100n\Omega');