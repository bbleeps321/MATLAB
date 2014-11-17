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

%% 1.1. [2 10 1]
rng(100);
[W,x,accTr,accTs,nWts] = TrainNN2([2 10 1],train.dataVect,train.labels,.001,200,params);
figure; plot(accTr,'b'); hold on; plot(accTs,'r');
title('Accuracy [2 10 1]');
xlabel('# training iterations'); ylabel('Percent correct');
legend('Training','Testing');

%% [2 4 1]
rng(3);
[W,x,accTr,accTs] = TrainNN2([2 4 1],train.dataVect,train.labels,.001,200,params);
figure; plot(accTr,'b'); hold on; plot(accTs,'r');
title('Accuracy [2 4 1]');
xlabel('# training iterations'); ylabel('Percent correct');
legend('Training','Testing');

%% Plot number of weights with iterations for different mu.
params.wT = 1e-3; params.ShowProgress = 0;
rng(100); params.mu = 0;
[W,x,accTr,accTs,nWts] = TrainNN2([2 10 1],train.dataVect,train.labels,.001,200,params);
figure(101); plot(nWts,'b'); hold on;
figure(102); plot(accTr,'b'); hold on;
figure(103); plot(accTs,'b'); hold on;
fprintf('accTr=%f%%, accTs=%f%%\n',accTr(end),accTs(end));

% mu = .1
rng(100); params.mu = .1;
[W,x,accTr,accTs,nWts] = TrainNN2([2 10 1],train.dataVect,train.labels,.001,200,params);
figure(101); plot(nWts,'r');
figure(102); plot(accTr,'r');
figure(103); plot(accTs,'r');
fprintf('accTr=%f%%, accTs=%f%%\n',accTr(end),accTs(end));

% mu = .3
rng(100); params.mu = .3;
[W,x,accTr,accTs,nWts] = TrainNN2([2 10 1],train.dataVect,train.labels,.001,200,params);
fprintf('accTr=%f%%, accTs=%f%%\n',accTr(end),accTs(end));
figure(101); plot(nWts,'g');
xlabel('# training iterations'); ylabel(sprintf('Number weights magnitude > %.3f',params.wT));
title('Number of weights greater than threshold for different mu');
legend('\mu=0','\mu=.1','\mu=.3');
figure(102); plot(accTr,'g');
xlabel('# training iterations'); ylabel('Percent correct');
title('Training accuracy');
legend('\mu=0','\mu=.1','\mu=.3');
figure(103); plot(accTs,'g');
xlabel('# training iterations'); ylabel('Percent correct');
title('Testing accuracy');
legend('\mu=0','\mu=.1','\mu=.3');

%% Plot performance with subthreshold weights removed.
params.wT = 1e-3; params.ShowProgress = 0; params.removeWeights = 1;
rng(100); params.mu = 0;
[W,x,accTr,accTs] = TrainNN2([2 10 1],train.dataVect,train.labels,.001,200,params);
figure(301); plot(accTr,'b'); hold on;
figure(302); plot(accTs,'b'); hold on;
fprintf('accTr=%f%%, accTs=%f%%\n',accTr(end),accTs(end));

% mu = .1
rng(100); params.mu = .1;
[W,x,accTr,accTs] = TrainNN2([2 10 1],train.dataVect,train.labels,.001,200,params);
figure(301); plot(accTr,'r');
figure(302); plot(accTs,'r');
fprintf('accTr=%f%%, accTs=%f%%\n',accTr(end),accTs(end));

% mu = .3
rng(100); params.mu = .3;
[W,x,accTr,accTs] = TrainNN2([2 10 1],train.dataVect,train.labels,.001,200,params);
fprintf('accTr=%f%%, accTs=%f%%\n',accTr(end),accTs(end));
figure(301); plot(accTr,'g');
xlabel('# training iterations'); ylabel('Percent correct');
title('Training accuracy with small weights removed');
legend('\mu=0','\mu=.1','\mu=.3');
figure(302); plot(accTs,'g');
xlabel('# training iterations'); ylabel('Percent correct');
title('Testing accuracy with small weights removed');
legend('\mu=0','\mu=.1','\mu=.3');

%% Plot performance with different horizontal scaling on logistic function.
params.mu = 0; params.wT = 0; params.ShowProgress = 0; params.removeWeights = 0;
rng(100); params.alpha = 1;
[W,x,accTr,accTs,nWts] = TrainNN2([2 10 1],train.dataVect,train.labels,.001,200,params);
figure(201); plot(accTr,'b'); hold on;
figure(202); plot(accTs,'b'); hold on;

% alpha = .9
rng(100); params.alpha = .9;
[W,x,accTr,accTs] = TrainNN2([2 10 1],train.dataVect,train.labels,.001,200,params);
figure(201); plot(accTr,'r'); hold on;
figure(202); plot(accTs,'r'); hold on;

% alpha = 1.1
rng(100); params.alpha = 1.1;
[W,x,accTr,accTs] = TrainNN2([2 10 1],train.dataVect,train.labels,.001,200,params);
figure(201); plot(accTr,'g'); hold on;
figure(202); plot(accTs,'g'); hold on;

% alpha = 1.5
rng(100); params.alpha = 2;
[W,x,accTr,accTs] = TrainNN2([2 10 1],train.dataVect,train.labels,.001,200,params);
figure(201); plot(accTr,'k'); hold on;
xlabel('# training iterations'); ylabel('Percent correct');
title('Training accuracy with different thresholding functions');
legend('\alpha = 1','\alpha = .9','\alpha = 1.1','\alpha = 2', 'Location','NorthWest');
figure(202); plot(accTs,'k'); hold on;
xlabel('# training iterations'); ylabel('Percent correct');
title('Testing accuracy with different thresholding functions');
legend('\alpha = 1','\alpha = .9','\alpha = 1.1','\alpha = 2', 'Location','NorthWest');

%% Try to see what hidden layers compute
rng(100);
[W,x,accTr,accTs,nWts] = TrainNN2([2 10 1],train.dataVect,train.labels,.001,200,params);
median(x{2}(:,idx1)')
median(x{2}(:,idx0)')
