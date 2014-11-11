close all; clear all;

load experiments.mat; % Loads experiments struct.

%% 1.1 Run SPRT with each experiment.
for i = 1:length(experiments)
    if i == 4
        a = 1;
    end
    [r{i},experiments{i}] = SimulateDiffusion([.3 .3],experiments{i});
end

%% 1.2 Plot diffusion for each.
figure(1);
for i = 1:length(experiments)
    subplot(3,2,i);
    L = length(r{i});
    plot(1:L,r{i}); hold on;
    plot(1:L,ones(1,L)*experiments{1}.T_0,'k--');
    plot(1:L,ones(1,L)*experiments{1}.T_1,'k--');
    title(sprintf('Diffusion for Experiment %d',i));
    xlabel('Time (observations)');
    ylabel('Log probability ratio');
end

%% 1.3 Calculate each person's cumulative score.
results.scoreVector = zeros(1,26);
for i = 1:length(experiments)
    exp = experiments{i};
    right = exp.playersGuess == exp.trueAnswer;
    scores = right.*100 - (~right.*100) - 5*exp.playersResponseTime;
    results.scoreVector = results.scoreVector + scores;
end
[~,results.rankVector] = sort(results.scoreVector,2,'descend');

%% 1.4 Calculate strategy scores.
results.strategyScoreVector = zeros(1,26);
for i = 1:length(experiments)
    % Only count if SPRT made a decision.
    if exp.sprtGuess == -1 continue; end
    
    exp = experiments{i};
    correctVal = 1./(1+(exp.playersGuess-exp.sprtGuess).^2);
    scores = right.*correctVal;
    results.strategyScoreVector = results.strategyScoreVector + scores;
end
[~,results.strategyRankVector] = ...
    sort(results.strategyScoreVector,2,'descend');

% Save results.
save('results.mat','results');
save('experiments.mat','experiments');
