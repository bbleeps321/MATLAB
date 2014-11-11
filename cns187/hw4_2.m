close all; %clear all;
rng(5)
P0 = 1/100;     % NumGreen/Total in cup 0
P1 = 10/100;    % NumGreen/Total in cup 1
tmax = 50;

%% 2.1 Show diffusions for K_B and three different C_t with Becky.
figure(1);
K_B = .1;
C_t = [.1 1 5];
err = {};
for i = 1:length(C_t)
    err{i} = @(t) 1 - 1/(1+K_B*C_t(i));
end

[r,y,ytrue,T0,T1,obs]=SimulateDiffusionTimeCost(err,P0,P1,tmax);
for i = 1:length(C_t)
    subplot(1,3,i);
    plot(r(i,:)); hold on;
    plot(T0(i,:),'k--');
    plot(T1(i,:),'k--');

    xlabel('Time (observations)');
    ylabel('Log probability ratio r');
    title(sprintf('Becky Diffusion for \n K_B=%f, C_t=%f \n yTrue = %d',K_B,C_t(i),ytrue));
    axis([0,length(r(i,:))+1,...
        min(min(T0(i,:)),min(r(i,:)))-.5, max(max(T1(i,:)),max(r(i,:)))+.5]);
end

%% 2.2 Show diffusions for C_t and many different K_Bs with Becky.
N = 500; tmax = 100;
rng(100);
C_t = 1;
K_B = 10.^([-2:.25:2]);
score = zeros(N,length(K_B));
err = {};
for i = 1:length(K_B)
    err{i} = @(t) 1 - 1/(1+K_B(i)*C_t);
end

for i=1:N
    [r,y,ytrue,T0,T1,obs,Td]=SimulateDiffusionTimeCost(err,P0,P1,tmax);
    score(i,:) = (100*(y==ytrue) - 100*(y~=ytrue) - C_t*Td)';
end
score = mean(score);
figure(2);
semilogx(K_B,score);
title('Average score vs K_B');
xlabel('K_B'); ylabel('Average score');

%% 2.3 Show diffusions for K_B and three different C_t with Mitt.
rng(7);
figure(3);
tmax = 50;
K_M = .1;
C_t = [.1 .8 1.5];
err = {};
for i = 1:length(C_t)
    err{i} = @(t) 1 - 1/(1+K_M*C_t(i)*t);
end

[r,y,ytrue,T0,T1,obs]=SimulateDiffusionTimeCost(err,P0,P1,tmax);
for i = 1:length(C_t)
    subplot(1,3,i);
    plot(r(i,:)); hold on;
    plot(T0(i,:),'k--');
    plot(T1(i,:),'k--');

    xlabel('Time (observations)');
    ylabel('Log probability ratio r');
    title(sprintf('Mitt Diffusion for \n K_B=%f, C_t=%f \n yTrue = %d',K_M,C_t(i),ytrue));
    axis([0,length(r(i,:))+1,...
        min(min(T0(i,:)),min(r(i,:)))-.5, max(max(T1(i,:)),max(r(i,:)))+.5]);
end

%% 2.4 Show diffusions for C_t and many different K_Bs with Mitt.
N = 500; tmax = 100;
rng(100);
C_t = .1;
K_M = 10.^([-2:.25:2]);
score = zeros(N,length(K_M));
err = {};
for i = 1:length(K_M)
    err{i} = @(t) 1 - 1/(1+K_M(i)*C_t*t);
end

for i=1:N
    [r,y,ytrue,T0,T1,obs,Td]=SimulateDiffusionTimeCost(err,P0,P1,tmax);
    score(i,:) = (100*(y==ytrue) - 100*(y~=ytrue) - C_t*Td)';
end
score = mean(score);
figure(4);
semilogx(K_M,score);
title('Average score vs K_M');
xlabel('K_M'); ylabel('Average score');