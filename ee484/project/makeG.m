% Makes the G matrix from the specified list of vectors.
% Position vectors defined column-wise. Needs a guess vector.
function G = makeG(X, x0)
    for (i=1:size(X,2))
        X(:,i) = -(X(:,i)-x0)./norm(X(:,i)-x0);
    end
    
    G = [X'];
end