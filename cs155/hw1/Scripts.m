formatSpec = '%f %f %f %f %f %f %f %f %f %f %f %f';
sizeA = [12 inf];

fileID = fopen('wine_training1.txt', 'r');
train1 = fscanf(fileID, formatSpec, sizeA)';
fclose(fileID);

fileID = fopen('wine_training2.txt', 'r');
train2 = fscanf(fileID, formatSpec, sizeA)';
fclose(fileID);

fileID = fopen('wine_training3.txt', 'r');
train3 = fscanf(fileID, formatSpec, sizeA)';
fclose(fileID);

fileID = fopen('wine_testing.txt', 'r');
testData = fscanf(fileID, formatSpec, sizeA)';
fclose(fileID);

%%
mu = 1e-4;
Xout = [ones(size(testData,1),1) testData(:,1:(end-1))]';
Yout = testData(:,end);
lambda = [.0001 .0005 .0025 .0125 .0625 .03125 .15625 7.815 39.0625 195.3125];
Ein = zeros(size(lambda));
Eout = zeros(size(lambda));
wNorm = zeros(size(lambda));
for i = 1:length(lambda);
    [w,E] = L2Regularization(train1,mu,lambda(i),.1);%1e5);
    Ein(i) = E(end);
    Eout(i) = mean((w'*Xout-Yout').^2);
    wNorm(i) = norm(w);
    fprintf('Ein = %f; Eout = %f; wNorm = %f\n',E(end),Eout(i),wNorm(i));
end