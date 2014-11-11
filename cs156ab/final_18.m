function final_18(K,gamma)
    warning('off','all');
    N = 100; T = 100; Nout = 1000;
    Ein = zeros(1,T);
    for (t = 1:T)
        X = 2*rand(N,2) - 1;
        y = sign(X(:,2)-X(:,1)+.25*sin(pi*X(:,1)));

        [idx,mu] = kmeans(X,K,'start','uniform','replicates',100);
        P = createPhi(X,mu,gamma);
        w = (P'*P)\P'*y;

        Ein(t) = sum(y' ~= sign(w'*P'))/N;
    end
    fprintf('K=%d, gamma=%f: Ein=0 %f%% of the time\n',K,gamma,...
        sum(Ein==0)*100/T);
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