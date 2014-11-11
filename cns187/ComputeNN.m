function [y,x] = ComputeNN(W,X)

nLayers = length(W)-1;
x = cell(1,nLayers);
x{1} = X;
s = cell(1,nLayers-1);
for i = 2:nLayers
    s{i-1} = W{i}*[ones(1,size(x{i-1},2));x{i-1}];
    x{i} = 1./(1+exp(-s{i-1}));
end

y = x{end};