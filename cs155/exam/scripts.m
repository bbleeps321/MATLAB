%%
image = imread('flower.png');
imageBW = rgb2gray(image);
imshow(imageBW)

K1 = [.0043 .0144 .0214 .0144 .0043; .0144 .0478 .0712 .0478 .0144;...
    .0214 .0712 .1062 .0712 .0214; .0144 .0478 .0712 .0478 .0144; .0043 .0144 .0214 .0144 .0043];
K2 = [.0068 .0225 .0335 .0225 .0068; .0225 .0746 .1112 .0746 .0225; .0335 .1112 .1660 .1112 .0335;...
    .0225 .0746 .1112 .0746 .0225; .0068 .0225 .0335 .0225 .0068];
K3 = [0 0 0 0 0; 0 0 0 0 0; 0 0 .8 0 0; 0 0 0 0 0; 0 0 0 0 0];

figure;
IM = conv2(imageBW,K1);
imshow(IM/max(max(IM)));
title('K1');

figure;
IM = conv2(imageBW,K2);
imshow(IM/max(max(IM)));
title('K2');

figure;
IM = conv2(imageBW,K3);
imshow(IM/max(max(IM)));
title('K3');

%%
O = [.5 .5; .75 .25];
T = [.25 .75; .6 .4; 1/3 2/3];

Y = [1 1 1; 1 1 2; 1 2 1; 1 2 2; 2 1 1; 2 1 2; 2 2 1; 2 2 2];
x = [1 2 1];
P = zeros(1,8);
for i = 1:8
    y = Y(i,:);
    P(i) = T(1,y(1))*O(y(1),x(1))*T(y(1)+1,y(2))*O(y(2),x(2))*T(y(2)+1,y(3))*O(y(3),x(3));
end

%%
A = [1 2]*.01;
sum(A)
sqrt(sum(A.^2))

%%
A = [1 2 3; 4 5 6; 7 8 9]*.1;
trace(sqrt(A'*A))
sqrt(trace(A'*A))

%%
w = [.25 .1; .05 -.25];
x = [.1 .5];
y = .75;
u = [.5 -.1];
sig = @(s) exp(s)/(1+exp(s));

h1 = w(1,1)*x(1) + w(2,1)*x(2)
h2 = w(1,2)*x(1) + w(2,2)*x(2)
sigh1 = sig(h1)
sigh2 = sig(h2)

uh = u(1)*h1 + u(2)*h2
f = sig(uh)

-2*.5*.1*(.75-.5091)*(.5091)*(1-.5091)*(.5125)*(1-.5125)
