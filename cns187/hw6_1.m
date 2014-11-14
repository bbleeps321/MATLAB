%% Load labels and images.
train = load('mnist_train');
test = load('mnist_test');

% Reduce to only 0's and 1's. Reshape data to vector form.
idx = find(train.labels==1 | train.labels==0);
train.labels = train.labels(idx)';
train.data = train.data(:,:,idx);
train.dataVect = reshape(train.data,28*28,size(train.data,3));
idx = find(test.labels==1 | test.labels==0);
test.labels = test.labels(idx)';
test.data = test.data(:,:,idx);
test.dataVect = reshape(test.data,28*28,size(test.data,3));

%% Draw 10 images.
% for i=1:10
%     drawMNISTImage(trainImages(:,i));
%     fprintf('Image %d is a: %d\n',i,labels(i));
% end

%%
% rng(75);
[W,x,L] = TrainNN2([784 5 1],train.dataVect,train.labels,.05,50000);
% y = round(ComputeNN(W,Xtr));

%%
load dataset_2;
ytr = ytr';
% rng(75);
rand('seed',75);
x1 = Xtr(:,find(ytr));
x0 = Xtr(:,find(~ytr));

[W,x,L] = TrainNN2([2 5 5 1],Xtr,ytr,.01,50000);
% 
% figure(1);
% scatter(x1(1,:),x1(2,:),[],'b','filled'); hold on;
% scatter(x0(1,:),x0(2,:),[],'r','filled');
% xlabel('x1'); ylabel('x2'); title('Dataset 1 with Decision Boundaries');
% legend('y = 1','y = 0');
figure(2);
x1 = -2:.01:2;
x2 = -2:.01:2;
[p,q]= meshgrid(x1,x2);
X = [p(:) q(:)]';
y = ComputeNN(W,X);
Y = reshape(y,length(x1),length(x2));
y1 = X.*repmat(y==1,2,1);
y0 = X.*repmat(y~=1,2,1);
colormap('cool');
imagesc(x1,fliplr(x2),Y);
colorbar;
xlabel('x1'); ylabel('x2');
title('Heat map for network with architecture [2 5 5 1]');

figure; plot(L);