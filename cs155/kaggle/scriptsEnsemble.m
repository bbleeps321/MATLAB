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

%%
K = 5;
% nlearn = 1:25;
% nlearn = [25 50 100];
nlearn = [100 200 300 400 500 600 700];
[Xpart,ypart] = getPartitions(dataTr.X,dataTr.y,K);
accTr = zeros(length(nlearn),K);
accTs = zeros(length(nlearn),K);
for i = 1:length(nlearn)
    for j = 1:K
        ens = fitensemble(Xpart{1,j},ypart{1,j},'AdaBoostM1',nlearn(i),'Tree');
        ypred = predict(ens,Xpart{1,j});
        accTr(i,j) = mean(ypred == ypart{1,j});
        ypred = predict(ens,Xpart{2,j});
        accTs(i,j) = mean(ypred == ypart{2,j});
    end
end
figure;
plot(nlearn,[1-mean(accTr,2) 1-mean(accTs,2)]);
title('Error for different number of trees in AdaBoost ensemble');
xlabel('Number of trees');
ylabel('Error');
legend('Training','Testing');

% %% Adaboost ensemble. 100.
% ens100 = fitensemble(dataTr.X,dataTr.y,'AdaBoostM1',100,'Tree');
% ypred = predict(ens100,dataTr.X);
% mean(ypred == dataTr.y)
% predTs = predict(ens100,dataTs.X);
% printResults('kaggle_test_pred_ens100.csv',dataTs.ids,predTs);

%% Adaboost ensemble. 500.
ens500 = fitensemble(dataTr.X,dataTr.y,'AdaBoostM1',500,'Tree');
ypred = predict(ens500,dataTr.X);
mean(ypred == dataTr.y)
predTs = predict(ens500,dataTs.X);
printResults('kaggle_test_pred_ens500.csv',dataTs.ids,predTs);

% %% Adaboost ensemble. 1000.
% ens1000 = fitensemble(dataTr.X,dataTr.y,'AdaBoostM1',1000,'Tree');
% ypred = predict(ens1000,dataTr.X);
% mean(ypred == dataTr.y)
% predTs = predict(ens1000,dataTs.X);
% printResults('kaggle_test_pred_ens1000.csv',dataTs.ids,predTs);

