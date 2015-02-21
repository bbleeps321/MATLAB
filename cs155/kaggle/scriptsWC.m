% tf_idf
M = csvread('kaggle_train_wc.csv',1,0);
N = size(M,1); % Number of (training) features.

% training set
dataTr.ids = M(:,1);
dataTr.X = M(:,2:end-1);
dataTr.y = M(:,end);

% test set
M = csvread('kaggle_test_wc.csv',1,0);
dataTs.ids = M(:,1);
dataTs.X = M(:,2:end);

%% Default performance
partIdx = floor(N*4/5);
idtr = dataTr.ids(1:partIdx);
Xtr = dataTr.X(1:partIdx,:);
ytr = dataTr.y(1:partIdx);
idts = dataTr.ids(partIdx+1:end);
Xts = dataTr.X(partIdx+1:end,:);
yts = dataTr.y(partIdx+1:end);

% Train.
defaultTree = fitctree(Xtr,ytr);
ypred = predict(defaultTree,Xtr);
ypred2 = predict(defaultTree,Xts);
mean(ypred == ytr)
mean(ypred2 == yts)

%% Naive tree (no regularization).
defaultTree = fitctree(dataTr.X,dataTr.y);
predTs = predict(defaultTree,dataTs.X);
printResults('kaggle_test_pred_default_tree.csv',dataTs.ids,predTs);
ypred = predict(defaultTree,dataTr.X);
mean(ypred == dataTr.y)

%% Changing minimum number of elements per leaf node, with K-fold CV.
K = 5;
% minLeafSize = [1 5 10 20 50 100 200 300 400 500 600 700 800 900 1000];
minLeafSize = [1 5 10 25 50 100 250 500 750 1000];
minLeafSize = [1 5 10 25 50 60 70 80 90 100 250];
accTr = zeros(length(minLeafSize),K);
accTs = zeros(length(minLeafSize),K);
[Xpart,ypart] = getPartitions(dataTr.X,dataTr.y,K);
for i = 1:length(minLeafSize)
    for j = 1:K
        tree = fitctree(Xpart{1,j},ypart{1,j},'MinLeaf',minLeafSize(i));
        ypred = predict(tree,Xpart{1,j});
        accTr(i,j) = mean(ypred == ypart{1,j});
        ypred = predict(tree,Xpart{2,j});
        accTs(i,j) = mean(ypred == ypart{2,j});
    end
end
figure(10); plot(minLeafSize,[mean(accTr,2) mean(accTs,2)]);
title('Performance'); xlabel('Min leaf size'); ylabel('Accuracy');
legend('Training','Test');

%% Try tree with min leaf size 100.
tree100wc = fitctree(dataTr.X,dataTr.y,'MinLeaf',100);
predTs = predict(tree100wc,dataTs.X);
printResults('kaggle_test_pred_tree100wc.csv',dataTs.ids,predTs);
ypred = predict(tree100wc,dataTr.X);
mean(ypred == dataTr.y)

%% Try tree with min leaf size 50. (for word count)
tree50wc = fitctree(dataTr.X,dataTr.y,'MinLeaf',50);
predTs = predict(tree50wc,dataTs.X);
printResults('kaggle_test_pred_tree50wc.csv',dataTs.ids,predTs);
ypred = predict(tree50wc,dataTr.X);
mean(ypred == dataTr.y)

%% Try with random forests.

%% Default with MinLeaf back to 1. Find best number of trees.
partIdx = floor(N*4/5);
idtr = dataTr.ids(1:partIdx);
Xtr = dataTr.X(1:partIdx,:);
ytr = dataTr.y(1:partIdx);
idts = dataTr.ids(partIdx+1:end);
Xts = dataTr.X(partIdx+1:end,:);
yts = dataTr.y(partIdx+1:end);

K = [1 5:5:50];
accTr = zeros(1,length(K));
accTs = zeros(1,length(K));
for i = 1:length(K)
    fprintf('%d...\n',K(i));
    baggedEnsemble = TreeBagger(K(i),Xtr,ytr);
    ypred = str2num(cell2mat(predict(baggedEnsemble,Xtr)));
    accTr(i) = mean(ypred == ytr);
    ypred = str2num(cell2mat(predict(baggedEnsemble,Xts)));
    accTs(i) = mean(ypred == yts);    
end
figure(20);
plot(K,[accTr' accTs']);
title('Accuracy for different number of trees in bagged ensemble');
xlabel('Number of trees');
ylabel('Accuracy');
legend('Training','Testing');

%% Performance using bagging with 30 trees.
baggedEnsembleDefault = TreeBagger(30,dataTr.X,dataTr.y);
ypred = str2num(cell2mat(predict(baggedEnsembleDefault,dataTr.X)));
mean(ypred == dataTr.y)
predTs = str2num(cell2mat(predict(baggedEnsembleDefault,dataTs.X)));
printResults('kaggle_test_pred_default_baggedwc.csv',dataTs.ids,predTs);

%% Find best with min leaf size.
K = 5;
% minLeafSize = [1 5 10 20 50 100 200 300 400 500 600 700 800 900 1000];
minLeafSize = [1 5 10 25 50 100 250 500 750 1000];
accTr = zeros(length(minLeafSize),K);
accTs = zeros(length(minLeafSize),K);
[Xpart,ypart] = getPartitions(dataTr.X,dataTr.y,K);
for i = 1:length(minLeafSize)
    for j = 1:K
        baggedEnsemble = TreeBagger(30,Xpart{1,j},ypart{1,j},'MinLeaf',minLeafSize(i));
        ypred = str2num(cell2mat(predict(baggedEnsemble,Xpart{1,j})));
        accTr(i,j) = mean(ypred == ypart{1,j});
        ypred = str2num(cell2mat(predict(baggedEnsemble,Xpart{2,j})));
        accTs(i,j) = mean(ypred == ypart{2,j});
    end
end
figure(30); plot(minLeafSize,[mean(accTr,2) mean(accTs,2)]);
title('Bagged Performance'); xlabel('Min leaf size'); ylabel('Accuracy');
legend('Training','Test');

%% Bagged with 30 Trees, min leaf size 50
bagged30Ensemble50 = TreeBagger(30,dataTr.X,dataTr.y,'MinLeaf',50);
ypred = str2num(cell2mat(predict(bagged30Ensemble50,dataTr.X)));
mean(ypred == dataTr.y)
predTs = str2num(cell2mat(predict(bagged30Ensemble50,dataTs.X)));
printResults('kaggle_test_pred_30bagged50.csv',dataTs.ids,predTs);