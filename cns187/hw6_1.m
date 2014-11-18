%% Load labels and images.
train = load('mnist_train');
test = load('mnist_test');

Ntr = 2*300;

% Reduce training and test set to only 0's and 1's.
[Xtr,ytr] = ExtractDataByLabel(train,0,1,Ntr);
[params.Xts,params.yts] = ExtractDataByLabel(test,0,1);

%% 1.1. [2 10 1]
rng(100);
[W,x,accTr,accTs,nWts] = TrainNN2([2 10 1],Xtr,ytr,.001,200,params);
figure; plot(accTr,'b'); hold on; plot(accTs,'r');
title('Accuracy [2 10 1]');
xlabel('# training iterations'); ylabel('Percent correct');
legend('Training','Testing');

%% [2 4 1]
rng(3);
[W,x,accTr,accTs] = TrainNN2([2 4 1],Xtr,ytr,.001,200,params);
figure; plot(accTr,'b'); hold on; plot(accTs,'r');
title('Accuracy [2 4 1]');
xlabel('# training iterations'); ylabel('Percent correct');
legend('Training','Testing');

%% Plot number of weights with iterations for different mu.
params.wT = 1e-3; params.ShowProgress = 0;
rng(100); params.mu = 0;
[W,x,accTr,accTs,nWts] = TrainNN2([2 10 1],Xtr,ytr,.001,200,params);
figure(101); plot(nWts,'b'); hold on;
figure(102); plot(accTr,'b'); hold on;
figure(103); plot(accTs,'b'); hold on;
fprintf('accTr=%f%%, accTs=%f%%\n',accTr(end),accTs(end));

% mu = .1
rng(100); params.mu = .1;
[W,x,accTr,accTs,nWts] = TrainNN2([2 10 1],Xtr,ytr,.001,200,params);
figure(101); plot(nWts,'r');
figure(102); plot(accTr,'r');
figure(103); plot(accTs,'r');
fprintf('accTr=%f%%, accTs=%f%%\n',accTr(end),accTs(end));

% mu = .3
rng(100); params.mu = .3;
[W,x,accTr,accTs,nWts] = TrainNN2([2 10 1],Xtr,ytr,.001,200,params);
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

%% Plot performance with different horizontal scaling on logistic function.
params.mu = 0; params.wT = 0; params.ShowProgress = 0; params.removeWeights = 0;
rng(100); params.alpha = 1;
[W,x,accTr,accTs,nWts] = TrainNN2([2 10 1],Xtr,ytr,.001,200,params);
figure(201); plot(accTr,'b'); hold on;
figure(202); plot(accTs,'b'); hold on;

% alpha = .9
rng(100); params.alpha = .9;
[W,x,accTr,accTs] = TrainNN2([2 10 1],Xtr,ytr,.001,200,params);
figure(201); plot(accTr,'r'); hold on;
figure(202); plot(accTs,'r'); hold on;

% alpha = 1.1
rng(100); params.alpha = 1.1;
[W,x,accTr,accTs] = TrainNN2([2 10 1],Xtr,ytr,.001,200,params);
figure(201); plot(accTr,'g'); hold on;
figure(202); plot(accTs,'g'); hold on;

% alpha = 1.5
rng(100); params.alpha = 2;
[W,x,accTr,accTs] = TrainNN2([2 10 1],Xtr,ytr,.001,200,params);
figure(201); plot(accTr,'k'); hold on;
xlabel('# training iterations'); ylabel('Percent correct');
title('Training accuracy with different thresholding functions');
legend('\alpha = 1','\alpha = .9','\alpha = 1.1','\alpha = 2', 'Location','NorthWest');
figure(202); plot(accTs,'k'); hold on;
xlabel('# training iterations'); ylabel('Percent correct');
title('Testing accuracy with different thresholding functions');
legend('\alpha = 1','\alpha = .9','\alpha = 1.1','\alpha = 2', 'Location','NorthWest');

%% Find pair of digits with lowest test accuracy.
clear all; close all;

train = load('mnist_train'); % Load data
test = load('mnist_test');

Ntr = 2*300; % 300 training points.
params.mu = 0; % No regularization
params.ShowProgress = 0; % Don't show progress to speed things up.

% Iterate through all pairwise combinations of digits.
digits = 0:9;
AccTr = zeros(length(digits));
AccTs = zeros(length(digits));
h = waitbar(0,'Checking pairwise combinations...');
for i = 1:length(digits)
    for j = (i+1):length(digits)
        y0 = digits(i);
        y1 = digits(j);
        if y0==y1 % If twin digits, accuracy of 1.
            AccTr(i,j) = 1;
            AccTs(i,j) = 1;
            continue;
        end
        % Extract training and testing data matching these pair of digits.
        [Xtr,ytr] = ExtractDataByLabel(train,y0,y1,Ntr);
        [params.Xts,params.yts] = ExtractDataByLabel(test,y0,y1);
        
        % Train a network with these pair of digits.
        params.y0 = y0;
        params.y1 = y1;
        fprintf('Testing %d vs %d: ',y0,y1);
        
        [~,~,accTr,accTs,~] = TrainNN2([2 10 1],Xtr,ytr,.001,200,params);
        AccTr(i,j) = accTr(end);
        AccTs(i,j) = accTs(end);
        fprintf('\taccTr = %f, accTs = %f\n',accTr(end),accTs(end));
        
        waitbar(i*j/(length(digits)^2),h,'Checking pairwise combinations...');
    end
end
close(h);
