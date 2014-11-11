I = 15; eta = .1; w = [1;1];
err = @(u,v) (u*exp(v)-2*v*exp(-u))^2;
errgrad = @(u,v) (2*(u*exp(v)-2*v*exp(-u))).*[exp(v)+2*v*exp(-u); u*exp(v)-2*exp(-u)];

for (i=1:I)
    grad = errgrad(w(1),w(2));
    w(1) = w(1) - eta*grad(1);
    grad = errgrad(w(1),w(2));
    w(2) = w(2) - eta*grad(2);
end
error = err(w(1),w(2))