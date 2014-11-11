function final_16(K,gamma)
    warning('off','all');
    N = 100; T = 100; Nout = 1000;
    Ein = 0; Eout = 0;
    for (t = 1:T)
        X = 2*rand(N,2) - 1;
        y = sign(X(:,2)-X(:,1)+.25*sin(pi*X(:,1)));

        [idx,mu] = kmeans(X,K,'start','uniform','replicates',100);
        P = createPhi(X,mu,gamma);
        w = (P'*P)\P'*y;

        Xout = 2*rand(Nout,2) - 1;
        yout = sign(Xout(:,2)-Xout(:,1)+.25*sin(pi*Xout(:,1)));

        EinT = sum(y' ~= sign(w'*P'))/N;
        EoutT = sum(yout' ~= sign(w'*createPhi(Xout,mu,gamma)'))/Nout;
        Ein = Ein + EinT;
        Eout = Eout + EoutT;
    end
    Ein = Ein/T;
    Eout = Eout/T;
    fprintf('K=%d, gamma=%f: Ein=%f, Eout=%f\n',K,gamma,Ein,Eout);
end
function P = createPhi(X,mu,gamma)
    N = size(X,1);
    K = size(mu,1);
    P = ones(N,K+1);
    for (i = 1:N)
        for (k = 1:K)
            P(i,k+1) = exp(-gamma*norm(X(i,:)-mu(k,:))^2);
        end
    end    
end