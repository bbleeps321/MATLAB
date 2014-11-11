clear; close all;
intervals = linspace(10,200,10);
ratios = zeros(10,1);
figure;
cc = hsv(10);

% For each of the EPSC simulation data, find the peaks and
% find their ratios.
Sim001_V;
subplot(2,1,1); hold on; plot(t1,r1,'color',cc(1,:));
Sim001_All;
subplot(2,1,2); hold on; plot(t1,r1,'color',cc(1,:));
[maxtab mintab] = peakdet(r1,2);
ratios(1) = mintab(2,2)/mintab(1,2);

Sim002_V;
subplot(2,1,1); plot(t2,r2,'color',cc(2,:));
Sim002_All;
subplot(2,1,2); plot(t2,r2,'color',cc(2,:));
[maxtab mintab] = peakdet(r2,2);
ratios(2) = mintab(2,2)/mintab(1,2);

Sim003_V;
subplot(2,1,1); plot(t3,r3,'color',cc(3,:));
Sim003_All;
subplot(2,1,2); plot(t3,r3,'color',cc(3,:));
[maxtab mintab] = peakdet(r3,2);
ratios(3) = mintab(2,2)/mintab(1,2);

Sim004_V;
subplot(2,1,1); plot(t4,r4,'color',cc(4,:));
Sim004_All;
subplot(2,1,2); plot(t4,r4,'color',cc(4,:));
[maxtab mintab] = peakdet(r4,2);
ratios(4) = mintab(2,2)/mintab(1,2);

Sim005_V;
subplot(2,1,1); plot(t5,r5,'color',cc(5,:));
Sim005_All;
subplot(2,1,2); plot(t5,r5,'color',cc(5,:));
[maxtab mintab] = peakdet(r5,2);
ratios(5) = mintab(2,2)/mintab(1,2);

Sim006_V;
subplot(2,1,1); plot(t6,r6,'color',cc(6,:));
Sim006_All;
subplot(2,1,2); plot(t6,r6,'color',cc(6,:));
[maxtab mintab] = peakdet(r6,2);
ratios(6) = mintab(2,2)/mintab(1,2);

Sim007_V;
subplot(2,1,1); plot(t7,r7,'color',cc(7,:));
Sim007_All;
subplot(2,1,2); plot(t7,r7,'color',cc(7,:));
[maxtab mintab] = peakdet(r7,2);
ratios(7) = mintab(2,2)/mintab(1,2);

Sim008_V;
subplot(2,1,1); plot(t8,r8,'color',cc(8,:));
Sim008_All;
subplot(2,1,2); plot(t8,r8,'color',cc(8,:));
[maxtab mintab] = peakdet(r8,2);
ratios(8) = mintab(2,2)/mintab(1,2);

Sim009_V;
subplot(2,1,1); plot(t9,r9,'color',cc(9,:));
Sim009_All;
subplot(2,1,2); plot(t9,r9,'color',cc(9,:));
[maxtab mintab] = peakdet(r9,2);
ratios(9) = mintab(2,2)/mintab(1,2);

Sim010_V;
subplot(2,1,1); plot(t10,r10,'color',cc(10,:));
Sim010_All;
subplot(2,1,2); plot(t10,r10,'color',cc(10,:));
[maxtab mintab] = peakdet(r10,2);
ratios(10) = mintab(2,2)/mintab(1,2);

subplot(2,1,1);
title('Voltage Stimulus');
xlabel('Time (ms)');
ylabel('Voltage (mV)');
legend('T = 10 ms','T = 31.1 ms', 'T = 52.2 ms', 'T = 73.3 ms', 'T = 94.4 ms', ...
        'T = 115.6 ms', 'T = 136.7 ms', 'T = 157.8 ms', 'T = 178.9 ms', 'T = 200 ms');
subplot(2,1,2);
title('EPSC Response');
xlabel('Time (ms)');
ylabel('Voltage (mV)');

% Plot ratios as function of intervals
figure;
plot(intervals,ratios);
title('Paired Pulse Ratios of EPSC as Function of Intervals');
xlabel('Interval duration (ms)');
ylabel('Paired Pulse Ratio');