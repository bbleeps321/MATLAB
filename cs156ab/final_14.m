function final_14(K)
    warning('off','all');
    N = 100; T = 100; gamma = 1.5; C = 1e6; Nout = 1000;
    numDiscarded = 0;
    numSVMBetter = 0;
    for (t = 1:T)
        X = 2*rand(N,2) - 1;
        y = sign(X(:,2)-X(:,1)+.25*sin(pi*X(:,1)));

        % SVM
        model = svmtrain(y,X,sprintf('-t 2 -g %f -c %f -q',gamma,C));
        [predictLabel,acc,probVal] = svmpredict(y,X, model,'-q');
        Ein = 1-acc(1)/100;
        if (Ein ~= 0)
            numDiscarded = numDiscarded + 1;
            continue;
        end

        % RBF + Lloyd
        [idx,mu] = kmeans(X,K,'start','uniform','replicates',100);
        P = createPhi(X,mu,gamma);
        w = (P'*P)\P'*y;

        Xout = 2*rand(Nout,2) - 1;
        yout = sign(Xout(:,2)-Xout(:,1)+.25*sin(pi*Xout(:,1)));

        [predictLabel,acc,probVal] = svmpredict(yout,Xout, model,'-q');
        EoutSVM = 1-acc(1)/100;
        EoutRBF = sum(yout' ~= sign(w'*createPhi(Xout,mu,gamma)'))/Nout;

        numSVMBetter = numSVMBetter + (EoutSVM < EoutRBF);
    end
    fprintf('SVM is better than RBF %f%% of the time\n',...
        numSVMBetter*100/(T-numDiscarded));
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