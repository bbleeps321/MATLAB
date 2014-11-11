function [L U] = LUdecomp(A)
    n = length(A);
    
    % initialize
    L = eye(n,n);
    U = zeros(n,n);
    
    % loop
    for (j=1:n)
        for (i=1:n)
            if (i<=j)
                k = 1:(i-1);
                U(i,j)= A(i,j) - L(i,k)*U(k,j);
            else
                k = 1:(j-1);
                L(i,j) = (A(i,j) - L(i,k)*U(k,j))/U(j,j);
            end            
        end
    end    
end