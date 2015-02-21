%% Read data.
M = importdata('wdbc.data');
data.ytr = strcmp(M.textdata(1:400,2),'M'); % Diagnosis. M = 1, B = 0.
data.Xtr = M.data(1:400,:);
data.yts = strcmp(M.textdata(401:end,2),'M');
data.Xts = M.data(401:end,:);

%% Question 1: Minimal leaf node size as stopping criterion.
minLeafSize = [1:25]';
errTr = zeros(length(minLeafSize),1);
errTs = zeros(length(minLeafSize),1);
for i = 1:length(minLeafSize)
    tree = fitctree(data.Xtr,data.ytr,'MinLeaf',minLeafSize(i));
    ytr = predict(tree,data.Xtr);
    yts = predict(tree,data.Xts);
    errTr(i) = mean(ytr ~= data.ytr); % Percent incorrect.
    errTs(i) = mean(yts ~= data.yts); % Percent incorrect.
end
figure(1);
plot(minLeafSize,[errTr errTs]);
title('Error for different minimum leaf size criteria');
xlabel('Minimum leaf size'); ylabel('Error (percent incorrect)');
legend('Training error','Test error');

%% Question 2: Maximal tree depth as stopping criterion.
depth = 2:20;

% Simulate maximal tree depth by pruning away branches at greater depths.
% This was done by inspecting the tree diagram.
defaultTree = fitctree(data.Xtr,data.ytr);
view(defaultTree,'mode','graph');
toprune = cell(1,length(depth));
toprune{1} = [2 3];
toprune{2} = [4 6 7];
toprune{3} = [8 13];
toprune{4} = [14 16];
toprune{5} = [19 21];
% Past this level is the same as the default tree.

% Prune and test error now.
errTr = zeros(length(depth),1);
errTs = zeros(length(depth),1);
for i = 1:length(depth)
    if isempty(toprune{i})
        tree = defaultTree;
    else
        tree = prune(defaultTree,'nodes',toprune{i});
    end
    ytr = predict(tree,data.Xtr);
    yts = predict(tree,data.Xts);
    errTr(i) = mean(ytr ~= data.ytr); % Percent incorrect.
    errTs(i) = mean(yts ~= data.yts); % Percent incorrect.
end
figure(2);
plot(depth,[errTr errTs]);
title('Error for different maximum tree depth criteria');
xlabel('Maximum tree depth'); ylabel('Error (percent incorrect)');
legend('Training error','Test error');


% prune(defaultTree,'Nodes',i);