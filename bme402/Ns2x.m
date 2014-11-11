function x = Ns2x(N, s)

k = floor(N*s);
x = zeros(N,1);
p = randperm(N,k);
x(p) = 1;
