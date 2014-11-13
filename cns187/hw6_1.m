%% Load labels and images.
% http://ufldl.stanford.edu/wiki/index.php/Using_the_MNIST_Dataset
trainLabels = loadMNISTLabels('train-labels.idx1-ubyte');
trainImages = loadMNISTImages('train-images.idx3-ubyte');
testLabels = loadMNISTLabels('t10k-labels.idx1-ubyte');
testImages = loadMNISTImages('t10k-images.idx3-ubyte');

%% Draw 10 images.
for i=1:10
    drawMNISTImage(trainImages(:,i));
    fprintf('Image %d is a: %d\n',i,labels(i));
end