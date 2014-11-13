%% Load labels and images.
% http://ufldl.stanford.edu/wiki/index.php/Using_the_MNIST_Dataset
trainLabels = loadMNISTLabels('train-labels.idx1-ubyte');
trainImages = loadMNISTImages('train-images.idx3-ubyte');
testLabels = loadMNISTLabels('t10k-labels.idx1-ubyte');
testImages = loadMNISTImages('t10k-images.idx3-ubyte');

%% Draw 10 images.
% for i=1:10
%     drawMNISTImage(trainImages(:,i));
%     fprintf('Image %d is a: %d\n',i,labels(i));
% end

%%
rng(75);
[W,x,L] = TrainNN2([784 156800 100 1],trainImages,trainLabels',.1,1000);
y = round(ComputeNN(W,Xtr));

%%
load dataset_2;
ytr = ytr';
rng(75);
x1 = Xtr(:,find(ytr));
x0 = Xtr(:,find(~ytr));

[W,x,L] = TrainNN2([2 5 5 1],Xtr,ytr,.01,50000,100,.01);
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