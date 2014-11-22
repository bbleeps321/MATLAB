%% Load labels and images.
train = load('mnist_train');
test = load('mnist_test');

Ntr = 2*500;
Niter = 1e4;
lambda = 5e-4;

% Reduce training and test set to only 1's and 7's.
params.y0 = 7; params.y1 = 9;
[Xtr,ytr] = ExtractDataByLabel(train,params.y0,params.y1,Ntr);
[params.Xts,params.yts] = ExtractDataByLabel(test,params.y0,params.y1);
params.ShowProgress = 0;

%% 1.1. [2 6 1]
[W,x,errTr,errTs,nWts] = TrainNN2([2 6 1],Xtr,ytr,lambda,Niter,params);
fprintf('errTr=%f, errTs=%f\n',errTr(end),errTs(end));
save('hw6_1_1a');

% [2 1]
[W,x,errTr,errTs,nWts] = TrainNN2([2 1],Xtr,ytr,lambda,Niter,params);
fprintf('errTr=%f, errTs=%f\n',errTr(end),errTs(end));
save('hw6_1_1b');

%% Plot number of weights with iterations for different mu.
params.wT = 1e-3; params.ShowProgress = 0;
params.mu = 0;
[W,x,errTr,errTs,nWts] = TrainNN2([2 6 1],Xtr,ytr,lambda,Niter,params);
fprintf('errTr=%f, errTs=%f\n',errTr(end),errTs(end));
save('hw6_1_2a');

% mu = .001
params.mu = .001; params.wT = 1e-3;
[W,x,errTr,errTs,nWts] = TrainNN2([2 6 1],Xtr,ytr,lambda,Niter,params);
fprintf('errTr=%f, errTs=%f\n',errTr(end),errTs(end));
save('hw6_1_2b');

% mu = .01
params.mu = .01; params.wT = 1e-3;
[W,x,errTr,errTs,nWts] = TrainNN2([2 6 1],Xtr,ytr,lambda,Niter,params);
fprintf('errTr=%f, errTs=%f\n',errTr(end),errTs(end));
save('hw6_1_2c');

% mu = .1
params.mu = .1; params.wT = 1e-3;
[W,x,errTr,errTs,nWts] = TrainNN2([2 6 1],Xtr,ytr,lambda,Niter,params);
fprintf('errTr=%f, errTs=%f\n',errTr(end),errTs(end));
save('hw6_1_2d');

%% Plot performance with different horizontal scaling on logistic function.

% alpha = .1
params.alpha = .1;
[W,x,errTr,errTs] = TrainNN2([2 6 1],Xtr,ytr,lambda,Niter,params);
fprintf('errTr=%f, errTs=%f\n',errTr(end),errTs(end));
save('hw6_2_1b');

% alpha = .5
params.alpha = .5;
[W,x,errTr,errTs] = TrainNN2([2 6 1],Xtr,ytr,lambda,Niter,params);
fprintf('errTr=%f, errTs=%f\n',errTr(end),errTs(end));
save('hw6_2_1c');

% alpha = .9
params.alpha = .9;
[W,x,errTr,errTs] = TrainNN2([2 6 1],Xtr,ytr,lambda,Niter,params);
fprintf('errTr=%f, errTs=%f\n',errTr(end),errTs(end));
save('hw6_2_1d');

% alpha = 1.1
params.alpha = 1.1;
[W,x,errTr,errTs] = TrainNN2([2 6 1],Xtr,ytr,lambda,Niter,params);
fprintf('errTr=%f, errTs=%f\n',errTr(end),errTs(end));
save('hw6_2_1e');

% alpha = 1.5
params.alpha = 1.5;
[W,x,errTr,errTs] = TrainNN2([2 6 1],Xtr,ytr,lambda,Niter,params);
fprintf('errTr=%f, errTs=%f\n',errTr(end),errTs(end));
save('hw6_2_1f');

% alpha = 2
params.alpha = 2;
[W,x,errTr,errTs] = TrainNN2([2 6 1],Xtr,ytr,lambda,Niter,params);
fprintf('errTr=%f, errTs=%f\n',errTr(end),errTs(end));
save('hw6_2_1g');

%% Find pair of digits with lowest test accuracy.
clear all; close all;

train = load('mnist_train'); % Load data
test = load('mnist_test');

Ntr = 2*500; % 500 training points.
Niter = 1000;
params.alpha = 1;
lambda = .001;
params.mu = 0; % No regularization
params.ShowProgress = 0; % Don't show progress to speed things up.

% Iterate through all pairwise combinations of digits.
digits = 0:9;
ErrTr = zeros(length(digits));
ErrTs = zeros(length(digits));
h = waitbar(0,'Checking pairwise combinations...');
for i = 1:length(digits)
    for j = 1:length(digits)
        y0 = digits(i);
        y1 = digits(j);
        if y0==y1 % If twin digits, accuracy of 1.
            ErrTr(i,j) = 1;
            ErrTs(i,j) = 1;
            continue;
        end
        % Extract training and testing data matching these pair of digits.
        [Xtr,ytr] = ExtractDataByLabel(train,y0,y1,Ntr);
        [params.Xts,params.yts] = ExtractDataByLabel(test,y0,y1);
        
        % Train a network with these pair of digits.
        params.y0 = y0;
        params.y1 = y1;
        fprintf('Testing %d vs %d: ',y0,y1);
        
        [~,~,errTr,errTs,~] = TrainNN2([2 6 1],Xtr,ytr,lambda,Niter,params);
        
        ErrTr(i,j) = min(errTr(end),errTs(end));
        ErrTs(i,j) = max(errTr(end),errTs(end));
        fprintf('\terrTr = %f, errTs = %f\n',errTr(end),errTs(end));
        figure; plot(errTr); hold all; plot(errTs);
        title(sprintf('%d vs %d',y0,y1));
        
        waitbar(i*j/(length(digits)^2),h,'Checking pairwise combinations...');
    end
    save(sprintf('hw6_2_2_%d',i-1),'ErrTr','ErrTs');
end
close(h);
