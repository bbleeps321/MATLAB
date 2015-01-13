% Data should be arranged where each column is a feature
% and last column is output value/label.
function [w,E] = L2Regularization(data,mu,lambda,eps)

% w = 2*rand(size(data,2),1)-1;
w = zeros(size(data,2),1);
N = size(data,1);
X = [ones(N,1) data(:,1:(end-1))]';
Y = data(:,end);
E = [];
dw = 100000;
while norm(dw) > eps
    E(end+1) = mean((w'*X-Y').^2);
    dw = 2/N*sum(repmat(w'*X-Y',length(w),1).*X,2) + lambda*w/N;
    w = w - mu*dw;
%     idx = randperm(N);
%     for n = 1:N
%         xn = X(:,n); yn = Y(idx(n));
%         w = w - mu*(2/N*(w'*xn-yn)*xn+lambda*w);
%     end
%     ypred = round(w'*X);
%     E(i) = 1-sum(ypred == Y')/N;
%     norm(dw)
end




