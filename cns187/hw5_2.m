close all;
load dataset_2;
ytr = ytr';
yts = yts';
K = 50000;

%% 2.1. Architecture [2 5 5 1].
rng(75);
[W,x,L] = TrainNN([2 5 5 1],Xtr,ytr,.01,K);

figure(101);
plot(L);

% Calculate accuracy on training set.
y = round(ComputeNN(W,Xtr));
nCorrect = sum(y==ytr);
fracCorrect = nCorrect/length(ytr);
fprintf('Training set accuracy: %d/%d = %f\n',nCorrect,length(ytr),fracCorrect);

% Calculate accuracy on testing set.
y = round(ComputeNN(W,Xts));
nCorrect = sum(y==yts);
fracCorrect = nCorrect/length(yts);
fprintf('Testing set accuracy: %d/%d = %f\n',nCorrect,length(yts),fracCorrect);

% Plot results on training set
% figure(201);
% y = round(ComputeNN(W,Xtr));
% scatter(Xtr(1,:).*y,Xtr(2,:).*y,[],'g','filled'); hold on;
% scatter(Xtr(1,:).*(~y),Xtr(2,:).*(~y),[],'r','filled');


% figure;
% scatter(Xtr(1,:).*ytr,Xtr(2,:).*ytr,[],'g','filled'); hold on;
% scatter(Xtr(1,:).*(~ytr),Xtr(2,:).*(~ytr),[],'r','filled');

% Plot heat map.
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

save('results2_1.mat','W','nCorrect','fracCorrect','x','L');

%% 2.2. Architecture [2 2 1].
rng(75);
[W,x,L] = TrainNN([2 2 1],Xtr,ytr,.01,K);

figure(102);
plot(L);

% Calculate accuracy on training set.
y = round(ComputeNN(W,Xtr));
nCorrect = sum(y==ytr);
fracCorrect = nCorrect/length(ytr);
fprintf('Training set accuracy: %d/%d = %f\n',nCorrect,length(ytr),fracCorrect);

% Calculate accuracy on testing set.
y = round(ComputeNN(W,Xts));
nCorrect = sum(y==yts);
fracCorrect = nCorrect/length(yts);
fprintf('Testing set accuracy: %d/%d = %f\n',nCorrect,length(yts),fracCorrect);

% Plot heat map.
figure(4);
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
title('Heat map for network with architecture [2 2 1]');

save('results2_2.mat','W','nCorrect','fracCorrect','x','L');

%% 2.3 Architecture [2 5 1].
rng(75);
[W,x,L] = TrainNN([2 5 1],Xtr,ytr,.01,K);

figure(103);
plot(L);

% Calculate accuracy on training set.
y = round(ComputeNN(W,Xtr));
nCorrect = sum(y==ytr);
fracCorrect = nCorrect/length(ytr);
fprintf('Training set accuracy: %d/%d = %f\n',nCorrect,length(ytr),fracCorrect);

% Calculate accuracy on testing set.
y = round(ComputeNN(W,Xts));
nCorrect = sum(y==yts);
fracCorrect = nCorrect/length(yts);
fprintf('Testing set accuracy: %d/%d = %f\n',nCorrect,length(yts),fracCorrect);

% Plot heat map.
figure(6);
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
title('Heat map for network with architecture [2 5 1]');

save('results2_3.mat','W','nCorrect','fracCorrect','x','L');