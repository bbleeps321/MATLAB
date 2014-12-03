%% Load image and initialize parameters. Show raw image and do PCA.
clear; close all;
raw = im2double(rgb2gray(imread('staircase.jpg')));
[mm,nn] = size(raw);
sz = 8;
A = im2col(raw,[sz sz]);

figure; imshow(raw); title('Raw image');
[U,S,V] = svd(A,'econ');

% Plot singular values.
figure; loglog(diag(S));
title('Singular values');

% Show first 64 components.
figure;
for i=1:64
    subplot(sz,sz,i);
    block = reshape(U(:,i),sz,sz);
    imshow(block/max(max(block)),[0 1.1]);
end

% Reconstruct with limited number of components.
R = [2 8 32];
for i = 1:length(R)
    r = R(i);
    Ahat = U(:,1:r) * S(1:r,1:r) * V(:,1:r)';
    
    B = reconstructImage(Ahat,sz,sz,mm,nn);
    
    figure; imshow(B/max(max(B)));
    title(sprintf('R = %d',r));
    
    % Check sum of squares error
    a = sum((A(:) - Ahat(:)).^2);
    d = diag(S);
    b = sum(d(r+1:end).^2);
    fprintf('a = %f, b = %f\n',a,b);
end

%% MNIST images
clear; close all;

% Load and combine images into 560x560 image.
test = load('mnist_train');
N = 20;
mm = N*28; nn = N*28;
raw = zeros(mm,nn);
for i = 1:N
    for j = 1:N
        row = (i-1)*28+1;
        col = (j-1)*28+1;
        raw(row:row+27,col:col+27) = test.data(:,:,(i-1)*N+j);
    end
end

% Do PCA
sz = 8;
A = im2col(raw,[sz sz]);

figure; imshow(raw); title('Raw image');
[U,S,V] = svd(A,'econ');

% Plot singular values.
figure; loglog(diag(S));
title('Singular values');

% Show first 64 components.
figure;
for i=1:64
    subplot(sz,sz,i);
    block = reshape(U(:,i),sz,sz);
    imshow(block/max(max(block)),[0 1.1]);
end

% Reconstruct with limited number of components.
R = [2 8 32];
for i = 1:length(R)
    r = R(i);
    Ahat = U(:,1:r) * S(1:r,1:r) * V(:,1:r)';
    
    B = reconstructImage(Ahat,sz,sz,mm,nn);
    
    figure; imshow(B/max(max(B)));
    title(sprintf('R = %d',r));
    
    % Check sum of squares error
    a = sum((A(:) - Ahat(:)).^2);
    d = diag(S);
    b = sum(d(r+1:end).^2);
    fprintf('a = %f, b = %f\n',a,b);
end