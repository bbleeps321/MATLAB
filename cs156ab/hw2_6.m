function Eout = hw2_6(N)
    K = 1000; % Num trials
    Eout = 0;
    for (k=1:K)
        Eout = Eout + trial(N);        
    end
    Eout=Eout/K;
    disp(sprintf('Eout=%f',Eout));
end

function Eout = trial(N)
    % Pick random target function f by defining random line points.
    p = 2*rand(2,2) - 1;
    D = 2*rand(2,N) - 1;    % Training data.
    
    X = [ones(N,1) D'];
    y = f(D,p)';
    w = (X'*X)\X'*y; % Regression
    
    % 1000 new points to test on
    Dtest = 2*rand(2,N) - 1;
    Eout = (sum(f(Dtest,p)~=sign(w'*[ones(1,N); Dtest])))/N;
end

function y = f(x, p)
    lineVal = (p(4)-p(2))/(p(3)-p(1))*(x(1,:) - p(1)) + p(2);
    y = (x(2,:) > lineVal)*2 - 1; % Result either -1 or 1.
end