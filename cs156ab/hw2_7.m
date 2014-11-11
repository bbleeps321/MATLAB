function iter = hw2_7(N)
    K = 1000; % Num trials
    iter = 0;
    for (k=1:K)
        iter = iter + trial(N);        
    end
    iter=iter/K;
    fprintf('iter=%f\n',iter);
end

function iter = trial(N)
    % Pick random target function f by defining random line points.
    p = 2*rand(2,2) - 1;
    D = 2*rand(2,N) - 1;    % Training data.
    
    X = [ones(N,1) D'];
    y = f(D,p)';
    w = (X'*X)\X'*y; % Regression
    
    iter = 0;
    i = 1;
    while (i < (N+1))
        % If error, correct w.
        yn = f(D(:,i),p);
        if (yn ~= sign(w'*[1;D(:,i)]))
            w = w + yn*[1;D(:,i)];
            iter = iter + 1;
            i = 1;  % Restart to make sure old points still ok.
        else
            i = i+1;
        end
    end
end

function y = f(x, p)
    lineVal = (p(4)-p(2))/(p(3)-p(1))*(x(1,:) - p(1)) + p(2);
    y = (x(2,:) > lineVal)*2 - 1; % Result either -1 or 1.
end