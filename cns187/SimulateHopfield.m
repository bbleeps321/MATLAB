function X = SimulateHopfield(W,x,T)

X = zeros(length(x),T);
X(:,1) = x';
idx = randperm(length(x));
while length(idx) < T
    idx = [idx randperm(length(x))];
end
for i = 1:T
    x(idx(i)) = sign(W(idx(i),:)*x);
    X(:,i+1) = x'; 
end
