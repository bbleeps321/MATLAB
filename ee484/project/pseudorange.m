% Calculate the estimated pseudorange from the specified position vector x
% source position xs with time bias b. Source positions defined column-wise
function rho = pseudorange(x,b,xs)
    for (i=1:size(xs,2))
        rho(i,1) = norm(xs(:,i)-x)+b;
    end
end