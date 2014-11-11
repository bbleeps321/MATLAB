w = [1;1]; eta = .1;
err = @(u,v) (u*exp(v)-2*v*exp(-u))^2;
errgrad = @(u,v) (2*(u*exp(v)-2*v*exp(-u))).*[exp(v)+2*v*exp(-u); u*exp(v)-2*exp(-u)];
for (i = 1:18)
    e = err(w(1),w(2));
    fprintf('i=%d, u=%f, v=%f, E=%E\n',i-1,w(1),w(2),e);
    w = w - eta*errgrad(w(1),w(2));
end
    