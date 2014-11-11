function Ein = hw2_5(N)
    K = 1000; % Num trials
    Ein = 0;
    for (k=1:K)
        Ein = Ein + trial(N);        
    end
    Ein=Ein/K;
    disp(sprintf('Ein=%f',Ein));
end

function Ein = trial(N)
    % Pick random target function f by defining random line points.
    p = 2*rand(2,2) - 1;
    D = 2*rand(2,N) - 1;    % Training data.
    
    X = [ones(N,1) D'];
    y = f(D,p)';
    w = (X'*X)\X'*y; % Regression
    Ein = (sum(y'~=sign(w'*[ones(1,N); D])))/N;
end

function y = f(x, p)
    % Output 1 if point x is greater than target function line and -1
    % if less than it.
    % Line is defined as the line passing through the points (p(1),p(2))
    % and (p(3),p(4)).
    lineVal = (p(4)-p(2))/(p(3)-p(1))*(x(1,:) - p(1)) + p(2);
    y = (x(2,:) > lineVal)*2 - 1; % Result either -1 or 1.
end