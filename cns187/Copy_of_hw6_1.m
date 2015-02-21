%% Load labels and images.
train = load('mnist_train');
test = load('mnist_test');

Ntr = 2*300;
Nts = 2*300;

% Reduce training set to only 0's and 1's. Reshape data to vector form.
idx1 = find(train.labels==1)';
idx0 = find(train.labels==0)';
idx = sort([idx1(1:Ntr/2) idx0(1:Ntr/2)]);
% idx = sort([idx1 idx0]);
train.labels = train.labels(idx)';
train.data = train.data(:,:,idx);
train.dataVect = reshape(train.data,28*28,size(train.data,3));

% Reduce testing set to only 0's and 1's. Reshape data to vector form.
idx1 = find(test.labels==1)';
idx0 = find(test.labels==0)';
% idx = sort([idx1(1:Nts/2) idx0(1:Nts/2)]);
idx = sort([idx1 idx0]);
test.labels = test.labels(idx)';
test.data = test.data(:,:,idx);
test.dataVect = reshape(test.data,28*28,size(test.data,3));
params.mu = 0;
params.Xts = test.dataVect;
params.yts = test.labels;

%% Draw 10 images.
% for i=11:20
%     figure;
%     imshow(train.data(:,:,i));
%     fprintf('Image %d is a: %d\n',i,train.labels(i));
% end

%% 1.1. [2 10 1]
rng(100);
K = 10; % Average over 10 times.
params.ShowProgress = 0;
accTr = zeros(K,200);
accTs = zeros(K,200);
h = waitbar(0,'Simulating...');
for i = 1:K
    [W,x,aTr,aTs] = TrainNN2([2 10 1],train.dataVect,train.labels,...
        .001,200,params);
    accTr(i,:) = aTr;
    accTs(i,:) = aTs;
    fprintf('iter%d: accTr=%.2f%%, accTs=%.2f%%\n',aTr(end),aTs(end));
    waitbar(i/K,h,'Simulating...');
end
close(h);
accTr = mean(accTr); accTs = mean(accTs);
fprintf('Architecture [2 10 1]: accTr=%.2f%%, accTs=%.2f%%\n',accTr(end),accTs(end));
figure; plot(accTr,'b'); hold on; plot(accTs,'r');
title(sprintf('Average Accuracy Over %d trials for architecture [2 10 1]',K));
xlabel('# training iterations'); ylabel('Percent correct');
legend('Training','Testing');

%% [2 4 1]
K = 10; % Average over 10 times.
params.ShowProgress = 0;
accTr = zeros(K,200);
accTs = zeros(K,200);
h = waitbar(0,'Simulating...');
for i = 1:K
    [W,x,aTr,aTs] = TrainNN2([2 4 1],train.dataVect,train.labels,...
        .001,200,params);
    accTr(i,:) = aTr;
    accTs(i,:) = aTs;
    waitbar(i/K,h,'Simulating...');
end
close(h);
accTr = mean(accTr); accTs = mean(accTr);
fprintf('Architecture [2 4 1]: accTr=%.2f%%, accTs=%.2f%%\n',accTr(end),accTs(end));
figure; plot(accTr,'b'); hold on; plot(accTs,'r');
title(sprintf('Average Accuracy Over %d trials for architecture [2 4 1]',K));
xlabel('# training iterations'); ylabel('Percent correct');
legend('Training','Testing');

%% [2 1]
% rng(100);
% [W,x,accTr,accTs] = TrainNN2([2 1],train.dataVect,train.labels,.001,200,params);
% x = ComputeNN(W,train.dataVect);
% y = round(x);
% figure;
% plot(accTr,'b'); hold on;
% plot(accTs,'r');
% title('Accuracy [2 1]');
% xlabel('# training iterations'); ylabel('Percent correct');
% legend('Training','Testing');

%% Using provided training.
% params.layersDims = [2 10 1];
% params.learningRate = .01;
% params.maxIterations = 1000;
% W = trainMLP(train.dataVect, train.labels', params);