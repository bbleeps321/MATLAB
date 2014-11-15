% ==============================================================
% Homework 5: Feed Forward NN implementation
% =============================================================== 

clear;clc;
%% LOAD DATASET AND SET PARAMETERS

load('dataset_2.mat');

% dimensions of all layers (except input)
paramStruct.layersDims = [5, 5, 1];
% learning rate of the gradient descent weight update
paramStruct.learningRate = 0.01;
% maximum number of iterations of the backpropagation
paramStruct.maxIterations = 50000;

%% TRAIN NETWORK

weights = trainMLP( Xtr, ytr, paramStruct );

%% VISUALIZE RESULTS

% Generate a dense grid X of the input domain.
gridSize = 41;
grid1D = linspace(-3,3,gridSize);
[xx, yy] = meshgrid(grid1D,grid1D);    
X = [xx(:) yy(:)]'; 

% make predictions on the grid points
prediction = testMLP( X, weights, paramStruct );
prediction = reshape( prediction, gridSize, gridSize );

% visualize predictions
figure(100); clf;
subplot(121);
plot(Xtr(1,ytr==1), Xtr(2,ytr==1), 'go'); hold on;
plot(Xtr(1,ytr==0), Xtr(2,ytr==0), 'r*');
xlim([min(grid1D) max(grid1D)]);
ylim([min(grid1D) max(grid1D)]);
subplot(122);
surf(grid1D,grid1D,prediction); view(2); colormap(summer);
xlim([min(grid1D) max(grid1D)]);
ylim([min(grid1D) max(grid1D)]);

% compute test error
ypred = testMLP( Xts, weights, paramStruct )' > 0.5;
fprintf('Test accuracy = %.2f%%\n', 100*mean((yts == ypred)));
