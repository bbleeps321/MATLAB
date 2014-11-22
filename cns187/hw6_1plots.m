%% mu
load('hw6_1_2a.mat');
figure(1); loglog(errTr,'b'); hold on;
figure(2); loglog(errTs,'b'); hold on;
figure(3); plot(nWts,'b'); hold on;
params.mu
load('hw6_1_2b.mat');
figure(1); loglog(errTr,'r'); hold on;
figure(2); loglog(errTs,'r'); hold on;
figure(3); plot(nWts,'r'); hold on;
params.mu
load('hw6_1_2c.mat');
figure(1); loglog(errTr,'g'); hold on;
figure(2); loglog(errTs,'g'); hold on;
figure(3); plot(nWts,'g'); hold on;
params.mu
load('hw6_1_2d.mat');
figure(1); loglog(errTr,'k'); hold on;
figure(2); loglog(errTs,'k'); hold on;
figure(3); plot(nWts,'k'); hold on;
params.mu

figure(1); title('Training Set Error');
xlabel('log # iterations'); ylabel('log error');
legend('\mu = 0','\mu = .001','\mu = .01','\mu = .1','Location','SouthWest');
figure(2); title('Testing Set Error');
xlabel('log # iterations'); ylabel('log error');
legend('\mu = 0','\mu = .001','\mu = .01','\mu = .1','Location','SouthWest');
figure(3); title('Number of Significant Weights During Training');
xlabel('# iterations'); ylabel('# significant weights');
legend('\mu = 0','\mu = .001','\mu = .01','\mu = .1','Location','SouthWest');

%% alpha
a = zeros(1,7);
ErrTr = zeros(1,7);
ErrTs = zeros(1,7);

ii = 1;
load('hw6_2_1b.mat');
figure(1); loglog(errTr); hold all;
figure(2); loglog(errTs); hold all;
a(ii) = params.alpha;
ErrTr(ii) = errTr(end);
ErrTs(ii) = errTs(end);

ii = ii+1;
load('hw6_2_1c.mat');
figure(1); loglog(errTr);
figure(2); loglog(errTs);
a(ii) = params.alpha;
ErrTr(ii) = errTr(end);
ErrTs(ii) = errTs(end);

ii = ii+1;
load('hw6_2_1d.mat');
figure(1); loglog(errTr);
figure(2); loglog(errTs);
a(ii) = params.alpha;
ErrTr(ii) = errTr(end);
ErrTs(ii) = errTs(end);

ii = ii+1;
load('hw6_1_1a.mat');
figure(1); loglog(errTr);
figure(2); loglog(errTs);
a(ii) = 1;
ErrTr(ii) = errTr(end);
ErrTs(ii) = errTs(end);

ii = ii+1;
load('hw6_2_1e.mat');
figure(1); loglog(errTr);
figure(2); loglog(errTs);
a(ii) = params.alpha;
ErrTr(ii) = errTr(end);
ErrTs(ii) = errTs(end);

ii = ii+1;
load('hw6_2_1f.mat');
figure(1); loglog(errTr);
figure(2); loglog(errTs);
a(ii) = params.alpha;
ErrTr(ii) = errTr(end);
ErrTs(ii) = errTs(end);

ii = ii+1;
load('hw6_2_1g.mat');
figure(1); loglog(errTr);
figure(2); loglog(errTs);
a(ii) = params.alpha;
ErrTr(ii) = errTr(end);
ErrTs(ii) = errTs(end);

figure(1); title('Training Set Error');
xlabel('log # iterations'); ylabel('log error');
legend('\alpha = .1','\alpha = .5','\alpha = .9','\alpha = 1','\alpha = 1.1',...
    '\alpha = 1.5','\alpha = 2','Location','SouthWest');
figure(2); title('Testing Set Error');
xlabel('log # iterations'); ylabel('log error');
legend('\alpha = .1','\alpha = .5','\alpha = .9','\alpha = 1','\alpha = 1.1',...
    '\alpha = 1.5','\alpha = 2','Location','SouthWest');

figure(3);
plot(a,ErrTr); hold on; plot(a,ErrTs,'r');
title('Error v;s thresholding function \alpha');
xlabel('\alpha'); ylabel('Error');
legend('Training','Testing');

%%
ERRTR = eye(10);
ERRTS = eye(10);

for i=1:9
    load(sprintf('hw6_2_2_%d',i-1));
    ERRTR(i,:) = ERRTR(i,:) + ErrTr;
    ERRTS(i,:) = ERRTS(i,:) + ErrTs;
end

rowLabels = {'0','1','2','3','4','5','6','7','8'};
columnLabels = {'1','2','3','4','5','6','7','8','9'};
matrix2latex(ERRTR(1:9,2:end), 'errtr.tex', 'rowLabels', rowLabels, 'columnLabels',...
    columnLabels, 'alignment', 'c', 'format', '%-6.4f', 'size', 'tiny');
matrix2latex(ERRTS(1:9,2:end), 'errts.tex', 'rowLabels', rowLabels, 'columnLabels',...
    columnLabels, 'alignment', 'c', 'format', '%-6.4f', 'size', 'tiny');

%% 
clear all; close all;

y0 = 7; y1 = 9;
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
ErrTr = zeros(1,length(digits));
ErrTs = zeros(1,length(digits));

% Extract training and testing data matching these pair of digits.
[Xtr,ytr] = ExtractDataByLabel(train,y0,y1,Ntr);
[params.Xts,params.yts] = ExtractDataByLabel(test,y0,y1);

% Train a network with these pair of digits.
params.y0 = y0;
params.y1 = y1;
fprintf('Testing %d vs %d: ',y0,y1);

[W,x,errTr,errTs,~] = TrainNN2([2 6 1],Xtr,ytr,lambda,Niter,params);

fprintf('\terrTr = %f, errTs = %f\n',errTr(end),errTs(end));

%%
ypred = ComputeNN(W,params.Xts) > .5;
ypred = ypred*y1 + ~ypred*y0;
erridx = find(ypred ~= params.yts);
length(erridx)
if ~isempty(erridx)
    for i=1:10
        idx = erridx(i);
        figure(i);imshow(reshape(params.Xts(:,idx),28,28));
        fprintf('Label as: %d. Actually: %d\n',ypred(idx),params.yts(idx));
    end
end