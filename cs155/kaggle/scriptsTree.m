% tf_idf
M = csvread('kaggle_train_tf_idf.csv',1,0);
N = size(M,1); % Number of (training) features.

% training set
dataTr.ids = M(:,1);
dataTr.X = M(:,2:end-1);
dataTr.y = M(:,end);

% test set
M = csvread('kaggle_test_tf_idf.csv',1,0);
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
% minLeafSize = [1 5 10 25 50 100 250 500 750 1000];
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
figure(10); plot(minLeafSize,[1-mean(accTr,2) 1-mean(accTs,2)]);
title('Performance'); xlabel('Min leaf size'); ylabel('Error');
legend('Training','Test');

%% Try tree with min leaf size 100.
tree100 = fitctree(dataTr.X,dataTr.y,'MinLeaf',100);
predTs = predict(tree100,dataTs.X);
printResults('kaggle_test_pred_tree100.csv',dataTs.ids,predTs);
ypred = predict(tree100,dataTr.X);
mean(ypred == dataTr.y)

%% Try with random forests.

%% Find best number of trees.
partIdx = floor(N*4/5);
idtr = dataTr.ids(1:partIdx);
Xtr = dataTr.X(1:partIdx,:);
ytr = dataTr.y(1:partIdx);
idts = dataTr.ids(partIdx+1:end);
Xts = dataTr.X(partIdx+1:end,:);
yts = dataTr.y(partIdx+1:end);

K = [1 10:10:100];
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
figure(2);
plot(K,[1-accTr' 1-accTs']);
title('Error for different number of trees in bagged ensemble');
xlabel('Number of trees');
ylabel('Error');
legend('Training','Testing');

%% Performance using bagging with 60 trees.
baggedEnsembleDefault = TreeBagger(60,dataTr.X,dataTr.y);
ypred = str2num(cell2mat(predict(baggedEnsembleDefault,dataTr.X)));
mean(ypred == dataTr.y)
predTs = str2num(cell2mat(predict(baggedEnsembleDefault,dataTs.X)));
printResults('kaggle_test_pred_default_bagged.csv',dataTs.ids,predTs);

% %% Find best with min leaf size.
% K = 5;
% % minLeafSize = [1 5 10 20 50 100 200 300 400 500 600 700 800 900 1000];
% minLeafSize = [1 5 10 25 50 100 250 500 750 1000];
% accTr = zeros(length(minLeafSize),K);
% accTs = zeros(length(minLeafSize),K);
% [Xpart,ypart] = getPartitions(dataTr.X,dataTr.y,K);
% for i = 1:length(minLeafSize)
%     for j = 1:K
%         baggedEnsemble = TreeBagger(10,Xpart{1,j},ypart{1,j},'MinLeaf',minLeafSize(i));
%         ypred = str2num(cell2mat(predict(baggedEnsemble,Xpart{1,j})));
%         accTr(i,j) = mean(ypred == ypart{1,j});
%         ypred = str2num(cell2mat(predict(baggedEnsemble,Xpart{2,j})));
%         accTs(i,j) = mean(ypred == ypart{2,j});
%     end
% end
% figure(3); plot(minLeafSize,[1-mean(accTr,2) 1-mean(accTs,2)]);
% title('Bagged Performance'); xlabel('Min leaf size'); ylabel('Error');
% legend('Training','Test');
% 
% %% Bagged with 60 Trees, min leaf size 100
% bagged60Ensemble100 = TreeBagger(60,dataTr.X,dataTr.y,'MinLeaf',10);
% ypred = str2num(cell2mat(predict(bagged60Ensemble100,dataTr.X)));
% mean(ypred == dataTr.y)
% predTs = str2num(cell2mat(predict(bagged60Ensemble100,dataTs.X)));
% printResults('kaggle_test_pred_60bagged10.csv',dataTs.ids,predTs);