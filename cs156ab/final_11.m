clear; close all;
x1 = [1 0 0 -1 0 0 -2];
x2 = [0 1 -1 0 2 -2 0];
y = [-1 -1 -1 1 1 1 1];
z1 = x2.^2 - 2*x1 - 1;
z2 = x1.^2 - 2*x2 + 1;
disp([z1' z2']);