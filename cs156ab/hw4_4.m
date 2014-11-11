K = 100000;
X = 2*rand(2,K)-1;
Y = sin(pi*X);
a = zeros(1,K);
for (i=1:K)
    a(i) = (X(:,i)'*X(:,i))\(X(:,i)'*Y(:,i));
end
abar = mean(a)

x = [-1:.01:1];
gbar = abar*x;
f = sin(pi*x);
bias = trapz((gbar-f).^2/length(x))

g = x'*a;
var = mean(trapz((g-repmat(gbar',1,K)).^2/length(x)))