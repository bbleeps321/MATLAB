clear; close all;

T = 10000; N = 100; gamma = 1.5; C = 1e6;
Ein = zeros(1,T);
for (t = 1:T)
    X = 2*rand(N,2) - 1;
    y = sign(X(:,2)-X(:,1)+.25*sin(pi*X(:,1)));
    model = svmtrain(y,X,sprintf('-t 2 -g %f -c %f -h 0 -q',gamma,C));
    [predictLabel,acc,probVal] = svmpredict(y,X, model,'-q');
    Ein(t) = 1-acc(1)/100;
end
fprintf('Fraction not linearly separable: %f\n',sum(Ein~=0)/T);