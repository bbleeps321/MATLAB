% Solve system Ly=b where L is a lower triangular matrix.
function y = fwsub(L,b)
    y = zeros(length(b),1);
    y(1) = b(1)/L(1,1);
    for (i=2:length(b))
        y(i)=(1/L(i,i))*(b(i)-L(i,:)*y);
    end
end