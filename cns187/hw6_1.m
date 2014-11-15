%% Load labels and images.
train = load('mnist_train');
test = load('mnist_test');

% Reduce training set to only 0's and 1's. Reshape data to vector form.
idx1 = find(train.labels==1)';
idx0 = find(train.labels==0)';
idx = sort([idx1(1:300) idx0(1:300)]);
train.labels = train.labels(idx)';
train.data = train.data(:,:,idx);
train.dataVect = reshape(train.data,28*28,size(train.data,3));

% Reduce testing set to only 0's and 1's. Reshape data to vector form.
idx1 = find(test.labels==1)';
idx0 = find(test.labels==0)';
idx = sort([idx1(1:50) idx0(1:50)]);
test.labels = test.labels(idx)';
test.data = test.data(:,:,idx);
test.dataVect = reshape(test.data,28*28,size(test.data,3));

%% Draw 10 images.
% for i=11:20
%     figure;
%     imshow(train.data(:,:,i));
%     fprintf('Image %d is a: %d\n',i,train.labels(i));
% end

%% 1.1. [2 10 1]
% rng(5);
[W,x,acc] = TrainNN2([2 10 1],train.dataVect,train.labels,.001,200);
x = ComputeNN(W,train.dataVect);
y = round(x);
% TODO: Plot figures.

%% [2 2 1]

%% [5 5 1]

%% Using provided training.
% params.layersDims = [2 10 1];
% params.learningRate = .01;
% params.maxIterations = 1000;
% W = trainMLP(train.dataVect, train.labels', params);