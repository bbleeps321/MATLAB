% Solve system Ux=y where U is an upper triangular matrix.
function x = bwsub(U,y)
    n = length(y);
    x = zeros(length(y),1);
    x(n) = y(n)/U(n,n);
    for (i=(n-1):-1:1)
        x(i)=(1/U(i,i))*(y(i)-U(i,:)*x);
    end
end