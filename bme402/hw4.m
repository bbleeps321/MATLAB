clear; close all;

% Models a basic visual response with lateral inhibition
% to a 1D image to a pulse.
h = [-1 2 -1];  % Receptor field response
i = 1:50;
x = ones(1,50).*(20<=i & i<30); % 1D input signal with centered pulse.
y = conv(x,h);
subplot(2,1,1);
plot(x);
axis([0 50 -1.5 1.5]);
title('Original Image');
subplot(2,1,2);
plot(y);
axis([0 50 -1.5 1.5]);
title('Processed Image');

% Models response to a gradient. Illustrates Mach band illusion.
x = floor(i/10);
x = x/max(x);
y = conv(x,h);
figure;
subplot(2,1,1);
plot(i,x);
axis([0 50 -.5 1.5]);
title('Original Mach Band Image');
subplot(2,1,2);
plot(i,y(1:50));
% axis([0 50 -2 2]);
title('Processed Mach Band Image');

% Does 2D image processing with "difference of Gaussian" function.
load lighthouse.mat;

% Generate and plot receptive field.
sigma = 2;
hh = fspecial('gaussian',[50 50],sigma) - fspecial('gaussian',[50 50],2*sigma);
hh = hh/max(max(hh));
figure;
mesh(hh);
title('Receptive Field');

% Process image.
figure;
yy = conv2(xx,hh,'same');
imshow(xx);
title('Original Image');
figure;
imshow(yy);
title('Processed Image');