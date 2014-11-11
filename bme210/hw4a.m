% HW4 Part 1 Script
t0 = 0; tf = 8;
    
% Case 1: 45g in a male
[t1 x1 BAC1] = alcohol_sim(45,1,t0,tf);

% Case 2: 45g in a female
[t2 x2 BAC2] = alcohol_sim(45,0,t0,tf);

% Case 3: 90g in a male
[t3 x3 BAC3] = alcohol_sim(90,1,t0,tf);

% Case 4: 90g in a female
[t4 x4 BAC4] = alcohol_sim(90,0,t0,tf);

% Plot
subplot(2,1,1);
hold on;
plot(t1,x1(:,1),'r');
plot(t2,x2(:,1),'g');
plot(t3,x3(:,1),'b');
plot(t4,x4(:,1),'k');
axis([0 8 0 100]);
title('Alcohol in Stomach over Time');
xlabel('Time (hr)');
ylabel('Amount of Alcohol in Stomach (g)');
legend('Male - 45g dose', 'Female - 45g dose', 'Male - 90g dose', 'Female - 90g dose', 'Location', 'NorthEast');

subplot(2,1,2);
hold on;
plot(t1,BAC1,'r');
plot(t2,BAC2,'g');
plot(t3,BAC3,'b');
plot(t4,BAC4,'k');
title('BAC over Time');
xlabel('Time (hr)');
ylabel('BAC (%)');
legend('Male - 45g dose', 'Female - 45g dose', 'Male - 90g dose', 'Female - 90g dose', 'Location', 'NorthEast');
% End Script