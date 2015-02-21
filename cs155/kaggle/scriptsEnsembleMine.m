load kaggle_train_mine;
N = size(D,1); % Number of (training) features.

% training set
dataTr.ids = D(:,1);
dataTr.X = D(:,2:end-1);
dataTr.y = D(:,end);

% test set
load kaggle_test_mine;
dataTs.ids = D(:,1);
dataTs.X = D(:,2:end);

%%
K = 5;
nlearn = [100 500 1500 2000 3000];
[Xpart,ypart] = getPartitions(dataTr.X,dataTr.y,K);
accTr = zeros(length(nlearn),K);
accTs = zeros(length(nlearn),K);
for i = 1:length(nlearn)
    fprintf('n=%d',nlearn(i));
    for j = 1:K
        ens = fitensemble(Xpart{1,j},ypart{1,j},'AdaBoostM1',nlearn(i),'Tree');
        ypred = predict(ens,Xpart{1,j});
        accTr(i,j) = mean(ypred == ypart{1,j});
        ypred = predict(ens,Xpart{2,j});
        accTs(i,j) = mean(ypred == ypart{2,j});
        fprintf('.');
    end
    fprintf('\n');
end
figure;
plot(nlearn,[1-mean(accTr,2) 1-mean(accTs,2)]);
title('Error for different number of trees in AdaBoost ensemble');
xlabel('Number of trees');
ylabel('Error');
legend('Training','Testing');

%% Adaboost ensemble. 100. Min leaf size 5
ens100mine = fitensemble(dataTr.X,dataTr.y,'AdaBoostM1',100,'Tree');
ypred = predict(ens100mine,dataTr.X);
mean(ypred == dataTr.y)
predTs = predict(ens100mine,dataTs.X);
printResults('kaggle_test_pred_ens100mine.csv',dataTs.ids,predTs);

%% Adaboost ensemble. 500.
ens500mine = fitensemble(dataTr.X,dataTr.y,'AdaBoostM1',500,'Tree');
ypred = predict(ens500mine,dataTr.X);
mean(ypred == dataTr.y)
predTs = predict(ens500mine,dataTs.X);
printResults('kaggle_test_pred_ens500mine.csv',dataTs.ids,predTs);

%% Adaboost ensemble. 1000.
ens1000mine = fitensemble(dataTr.X,dataTr.y,'AdaBoostM1',1000,'Tree');
ypred = predict(ens1000mine,dataTr.X);
mean(ypred == dataTr.y)
predTs = predict(ens1000mine,dataTs.X);
printResults('kaggle_test_pred_ens1000mine.csv',dataTs.ids,predTs);

%% Adaboost ensemble. 1500.
ens1500mine = fitensemble(dataTr.X,dataTr.y,'AdaBoostM1',1500,'Tree');
ypred = predict(ens1500mine,dataTr.X);
mean(ypred == dataTr.y)
predTs = predict(ens1500mine,dataTs.X);
printResults('kaggle_test_pred_ens1500mine.csv',dataTs.ids,predTs);

%% Adaboost ensemble. 2000.
ens2000mine = fitensemble(dataTr.X,dataTr.y,'AdaBoostM1',2000,'Tree');
ypred = predict(ens2000mine,dataTr.X);
mean(ypred == dataTr.y)
predTs = predict(ens2000mine,dataTs.X);
printResults('kaggle_test_pred_ens2000mine.csv',dataTs.ids,predTs);