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
[Xpart,ypart] = getPartitions(dataTr.X,dataTr.y,K);
errTr = zeros(1,K);
errTs = zeros(1,K);
% for i = 1:length(nlearn)
    for j = 1:K
        svm = fitcsvm(Xpart{1,j},ypart{1,j},'KernelFunction','rbf','Standardize',true);
        ypred = predict(svm,Xpart{1,j});
        errTr(1,j) = mean(ypred ~= ypart{1,j});
        ypred = predict(svm,Xpart{2,j});
        errTs(1,j) = mean(ypred ~= ypart{2,j});
    end
% end
% figure;
% plot(nlearn,[mean(accTr,2) mean(accTs,2)]);
mean(errTr)
mean(errTs)

%%
SVMModel = fitcsvm(dataTr.X,dataTr.y,'KernelFunction','rbf','Standardize',true);
ypred = predict(SVMModel,dataTr.X);
mean(ypred == dataTr.y)
predTs = predict(SVMModel,dataTs.X);
printResults('kaggle_test_pred_svm_rbf.csv',dataTs.ids,predTs);
