%% 1C. Load data
formatSpec = '%f %f %f %f %f %f %f %f %f %f %f %f';
sizeA = [12 inf];

fileID = fopen('wine_training1.txt', 'r');
train{1} = fscanf(fileID, formatSpec, sizeA)';
fclose(fileID);

fileID = fopen('wine_training2.txt', 'r');
train{2} = fscanf(fileID, formatSpec, sizeA)';
fclose(fileID);

fileID = fopen('wine_training3.txt', 'r');
train{3} = fscanf(fileID, formatSpec, sizeA)';
fclose(fileID);

fileID = fopen('wine_testing.txt', 'r');
testData = fscanf(fileID, formatSpec, sizeA)';
fclose(fileID);

%% 1C. Train
mu = 1e-4;
Xout = [ones(size(testData,1),1) testData(:,1:(end-1))]';
Xout = [testData(:,1:(end-1))]';
Yout = testData(:,end);
lambda = [.0001 .0005 .0025 .0125 .0625 .3125 1.5625 7.815 39.0625 195.3125];
Ein = zeros(3,length(lambda));
Eout = zeros(3,length(lambda));
wNorm = zeros(3,length(lambda));
for f = 1:3
    for i = 1:length(lambda);
        [w,E] = L2Regularization(train{f},mu,lambda(i),.1);%1e5);
        Ein(f,i) = E(end);
        Eout(f,i) = mean((w'*Xout-Yout').^2);
        wNorm(f,i) = norm(w);
        fprintf('file%d: Ein = %f; Eout = %f; wNorm = %f\n',f,E(end),Eout(i),wNorm(i));
    end
end

%% 1C. Plot errors
figure(1);
loglog(lambda,Ein');
xlabel('\lambda'); ylabel('log(E_{in})');
title('In-Sample Error vs Different Values of \lambda');
legend('Dataset 1','Dataset 2','Dataset 3');

figure(2);
loglog(lambda,Eout');
xlabel('\lambda'); ylabel('log(E_{out})');
title('Out-of-Sample Error vs Different Values of \lambda');
legend('Dataset 1','Dataset 2','Dataset 3');

figure(3);
loglog(lambda,wNorm');
xlabel('\lambda'); ylabel('norm(w)');
title('Norm of w vs Different Values of \lambda');
legend('Dataset 1','Dataset 2','Dataset 3');

%%
%% 2B.
data = dlmread('question2data.txt','\t');
X = data(:,1:9);
Y = data(:,10);

%% Lasso
lambda = 0:.1:5;
W = zeros(9,length(lambda));
for i = 1:length(lambda)
    W(:,i) = lasso(X,Y,'Lambda',lambda(i));
end

figure;
plot(lambda,W);
title('Weights from Lasso Regularization vs \lambda');
xlabel('\lambda'); ylabel('Weights');
legend('w_1','w_2','w_3','w_4','w_5','w_6','w_7','w_8','w_9');


%% Ridge
lambda = 0:100:50000;
W = zeros(9,length(lambda));
for i = 1:length(lambda)
    W(:,i) = ridge(Y,X,lambda(i));
end

figure;
plot(lambda,W);
title('Weights from Ridge Regularization vs \lambda');
xlabel('\lambda'); ylabel('Weights');
legend('w_1','w_2','w_3','w_4','w_5','w_6','w_7','w_8','w_9');
