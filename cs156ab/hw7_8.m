function hw7_8(N)
    K = 100;
    svmBetterCount = 0;
    Nsvm = 0; Epla = 0; Esvm = 0;
    
    for (k = 1:K)
        [EplaTrial,EsvmTrial,NsvmTrial] = trial(N);
        Nsvm = Nsvm + NsvmTrial;
        Epla = Epla + EplaTrial;
        Esvm = Esvm + EsvmTrial;
        svmBetterCount = svmBetterCount + (EsvmTrial < EplaTrial);
    end
    fprintf('Average Esvm=%f, Average Epla=%f\n',Esvm/K,Epla/K);
    fprintf('SVM is better than PLA %f percent of the time\n',svmBetterCount/K*100);
    fprintf('Average number of support vectors = %f\n',Nsvm/K); 
end

function [Epla Esvm Nsvm] = trial(N)
    % Pick random target function f by defining random line points.
    p = 2*rand(2,2) - 1;
    X = 2*rand(2,N) - 1;    % Training data
    Y = f(X,p);
    while (sum(Y) == length(Y) || sum(Y) == -length(Y))
        p = 2*rand(2,2)-1;
        Y = f(X,p);
    end
    Nout = 1000;
    Xout = 2*rand(2,Nout) - 1; % Test data
    Yout = f(Xout,p);
    
    % PLA
    i = 1;
    wpla = zeros(3,1);
    while (i < (N+1))
        % If error, correct w.
        yn = f(X(:,i),p);
        if (yn ~= sign(wpla'*[1;X(:,i)]))
            wpla = wpla + yn*[1;X(:,i)];
            i = 1;  % Restart to make sure old points still ok.
        else
            i = i+1;
        end
    end    
    Epla = sum(Yout ~= sign(wpla'*[ones(1,Nout);Xout]))/Nout;
    
    % SVM
    Q = (Y'*Y).*(X'*X);
    thresh = 0.1;
    cvx_quiet true
    cvx_begin
        variable a(N)
        minimize(.5*a'*Q*a - ones(1,N)*a)
        subject to
            Y*a == 0
            0 <= a
    cvx_end;
    wsvm = sum(([a'.*Y; a'.*Y].*X)')';size(wsvm)
    idx = find(a > thresh,1);
    b = 1/Y(idx) - wsvm'*X(:,idx);
    
    Esvm = sum(Yout ~= sign(wsvm'*Xout+b*ones(1,Nout)))/Nout;
    Nsvm = sum(a > thresh);
end

function y = f(x, p)
    lineVal = (p(4)-p(2))/(p(3)-p(1))*(x(1,:) - p(1)) + p(2);
    y = (x(2,:) > lineVal)*2 - 1; % Result either -1 or 1.
end