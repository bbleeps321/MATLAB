% Simulates diffusion where the accepted error rate at each time point
% can be defined by a function handle. For multiple function handles
% simulates the diffusion for each but with the same set of observations.
% err: Function handle(s) for accepted error rate at each index.
% P0: P(x=1|y=0). Number of green/total in cup 0.
% P1: P(x=1|y=1). Number of green/total in cup 1.
% ytrue: True answer (actually selected cup).
% tmax: maximum number of observations to simulate for.
function [r,y,ytrue,T0,T1,obs,Td] = SimulateDiffusionTimeCost(err,P0,P1,tmax)

r = zeros(length(err),1);
y = nan(length(err),1);
d1 = log10(P1/P0);
d0 = log10((1-P1)/(1-P0));
Td = nan(length(err),1);

% Generate random observations based on selected cup.
if rand < .5
    ytrue = 1;
    obs = rand(1,tmax) < P1;
else
    ytrue = 0;
    obs = rand(1,tmax) < P0;
end

% Simulate for each error function.
for i = 1:length(err)
    t = 1;
    while t < tmax
        % Check threshold before next diffusion step.
        e = err{i}(t-1);
        T0(i,t) = log10(e/(1-e));
        T1(i,t) = log10((1-e)/e);    
        if r(i,t) > T1(i,t) && isnan(y(i)) % Decide 1
            y(i) = 1;
            Td(i) = t-1; % Decided before step t
        elseif r(i,t) < T0(i,t) && isnan(y(i)) % Decide 0
            y(i) = 0;
            Td(i) = t-1;
        end

        % No decision yet, generate an observation and update r(t).
        if obs(t) == 1
            r(i,t+1) = r(i,t) + d1;
        else
            r(i,t+1) = r(i,t) + d0;
        end

        t = t+1;
    end
end