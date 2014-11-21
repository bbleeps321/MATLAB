%% Load labels and images.
train = load('mnist_train');
test = load('mnist_test');

Ntr = 2*500;
Niter = 1e4;
lambda = 5e-4;

% Reduce training and test set to only 1's and 7's.
params.y0 = 1; params.y1 = 7;
[Xtr,ytr] = ExtractDataByLabel(train,params.y0,params.y1,Ntr);
[params.Xts,params.yts] = ExtractDataByLabel(test,params.y0,params.y1);
params.ShowProgress = 0;

%% 1.1. [2 4 1]
[W,x,errTr,errTs] = TrainNN2([2 4 1],Xtr,ytr,lambda,Niter,params);
figure; subplot(2,1,1); loglog(errTr,'b'); hold on; loglog(errTs,'r');
title('Accuracy [2 4 1]');
xlabel('log # training iterations'); ylabel('log error');
legend('Training','Testing','Location','NorthWest');

%% [2 2 1]
[W,x,errTr,errTs] = TrainNN2([2 2 1],Xtr,ytr,lambda,Niter,params);
subplot(2,1,2); loglog(errTr,'b'); hold on; loglog(errTs,'r');
title('Accuracy [2 2 1]');
xlabel('log # training iterations'); ylabel('log error');
legend('Training','Testing');

%% Plot number of weights with iterations for different mu.
params.wT = 1e-3; params.ShowProgress = 0;
params.mu = 0;
[W,x,errTr,errTs,nWts] = TrainNN2([2 10 1],Xtr,ytr,lambda,Niter,params);
figure(101); plot(nWts,'b'); hold on;
figure(102); plot(errTr,'b'); hold on;
figure(103); plot(errTs,'b'); hold on;
fprintf('errTr=%f%%, errTs=%f%%\n',errTr(end),errTs(end));

% mu = .1
params.mu = .1;
[W,x,errTr,errTs,nWts] = TrainNN2([2 10 1],Xtr,ytr,lambda,Niter,params);
figure(101); plot(nWts,'r');
figure(102); plot(errTr,'r');
figure(103); plot(errTs,'r');
fprintf('errTr=%f%%, errTs=%f%%\n',errTr(end),errTs(end));

% mu = .3
params.mu = .3;
[W,x,errTr,errTs,nWts] = TrainNN2([2 10 1],Xtr,ytr,lambda,Niter,params);
fprintf('errTr=%f%%, errTs=%f%%\n',errTr(end),errTs(end));
figure(101); plot(nWts,'g');
xlabel('# training iterations'); ylabel(sprintf('Number weights magnitude > %.3f',params.wT));
title('Number of weights greater than threshold for different mu');
legend('\mu=0','\mu=.1','\mu=.3');
figure(102); plot(errTr,'g');
xlabel('# training iterations'); ylabel('log error');
title('Training accuracy');
legend('\mu=0','\mu=.1','\mu=.3');
figure(103); plot(errTs,'g');
xlabel('# training iterations'); ylabel('log error');
title('Testing accuracy');
legend('\mu=0','\mu=.1','\mu=.3');

%% Plot performance with different horizontal scaling on logistic function.
params.mu = 0; params.wT = 0; params.ShowProgress = 0; params.removeWeights = 0;
params.alpha = 1;
[W,x,errTr,errTs,nWts] = TrainNN2([2 10 1],Xtr,ytr,lambda,Niter,params);
figure(201); plot(errTr,'b'); hold on;
figure(202); plot(errTs,'b'); hold on;

% alpha = .9
params.alpha = .9;
[W,x,errTr,errTs] = TrainNN2([2 10 1],Xtr,ytr,lambda,Niter,params);
figure(201); plot(errTr,'r'); hold on;
figure(202); plot(errTs,'r'); hold on;

% alpha = 1.1
params.alpha = 1.1;
[W,x,errTr,errTs] = TrainNN2([2 10 1],Xtr,ytr,lambda,Niter,params);
figure(201); plot(errTr,'g'); hold on;
figure(202); plot(errTs,'g'); hold on;

% alpha = 1.5
params.alpha = 2;
[W,x,errTr,errTs] = TrainNN2([2 10 1],Xtr,ytr,lambda,Niter,params);
figure(201); plot(errTr,'k'); hold on;
xlabel('# training iterations'); ylabel('log error');
title('Training accuracy with different thresholding functions');
legend('\alpha = 1','\alpha = .9','\alpha = 1.1','\alpha = 2', 'Location','NorthWest');
figure(202); plot(errTs,'k'); hold on;
xlabel('# training iterations'); ylabel('log error');
title('Testing accuracy with different thresholding functions');
legend('\alpha = 1','\alpha = .9','\alpha = 1.1','\alpha = 2', 'Location','NorthWest');

%% Find pair of digits with lowest test accuracy.
clear all; close all;

train = load('mnist_train'); % Load data
test = load('mnist_test');

Ntr = 2*300; % 300 training points.
Niter = 1000;
params.mu = 0; % No regularization
params.ShowProgress = 0; % Don't show progress to speed things up.

% Iterate through all pairwise combinations of digits.
digits = 0:9;
errTr = zeros(length(digits));
errTs = zeros(length(digits));
h = waitbar(0,'Checking pairwise combinations...');
for i = 1:length(digits)
    for j = (i+1):length(digits)
        y0 = digits(i);
        y1 = digits(j);
        if y0==y1 % If twin digits, accuracy of 1.
            errTr(i,j) = 1;
            errTs(i,j) = 1;
            continue;
        end
        % Extract training and testing data matching these pair of digits.
        [Xtr,ytr] = ExtractDataByLabel(train,y0,y1,Ntr);
        [params.Xts,params.yts] = ExtractDataByLabel(test,y0,y1);
        
        % Train a network with these pair of digits.
        params.y0 = y0;
        params.y1 = y1;
        fprintf('Testing %d vs %d: ',y0,y1);
        
        [~,~,errTr,errTs,~] = TrainNN2([2 10 1],Xtr,ytr,lambda,Niter,params);
        errTr(i,j) = errTr(end);
        errTs(i,j) = errTs(end);
        fprintf('\terrTr = %f, errTs = %f\n',errTr(end),errTs(end));
        
        waitbar(i*j/(length(digits)^2),h,'Checking pairwise combinations...');
    end
end
close(h);
