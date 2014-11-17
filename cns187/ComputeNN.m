function [y,x] = ComputeNN(W,X,alpha)

if nargin < 3
    alpha = 1;
end

nLayers = length(W);
x = cell(1,nLayers);
x{1} = X;
s = cell(1,nLayers-1);
for i = 2:nLayers
    s{i-1} = W{i}*[ones(1,size(x{i-1},2));x{i-1}];
    x{i} = 1./(1+exp(-alpha*s{i-1}));
end

y = x{end};