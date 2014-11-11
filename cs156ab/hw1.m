% Does perceptron learning experiment as described in hw1#7-10.
% N is number of training points.
% Outputs C (mean iterations to converge) and e (mean error b/w g and f).
function [C e] = hw1(N)
    K = 1000; % Num trials
    C = 0;
    e = 0;
    for (k=1:1000)
        [Ct et] = trial(N);
        C = C + Ct;
        e = e + et;
    end
    C = C/1000;
    e = e/1000;
    disp(C);
    disp(e);
end

function [Ct et] = trial(N)
    % Pick random target function f by defining random line points.
    p = 2*rand(4,1) - 1;
    D = 2*rand(2,N) - 1;    % Training data.
    w = zeros(3,1);     % Weights of hypothesis g. Initially 0.
    Ct = 0;     % Number of iterations.
    i = 1;
    while (i < (N+1))
        % If error, correct w.
        yn = f(D(:,i),p);
        if (yn ~= g(D(:,i),w))
            w = w + yn*[1;D(:,i)];
            Ct = Ct + 1;
            i = 1;  % Restart to make sure old points still ok.
        else
            i = i+1;
        end
    end
    
    % Generate 100 random test points to estimate error in g.
    T = 2*rand(2,100) - 1;
    et = 0;
    for (i=1:100)
        if (f(T(:,i),p) ~= g(T(:,i),w))
            et = et + 1;
        end
    end
    et = et/100;
end

function y = f(x, p)
    % Output 1 if point x is greater than target function line and -1
    % if less than it.
    % Line is defined as the line passing through the points (p(1),p(2))
    % and (p(3),p(4)).
    lineVal = (p(4)-p(2))/(p(3)-p(1))*(x(1) - p(1)) + p(2);
    y = (x(2) > lineVal)*2 - 1; % Result either -1 or 1.
end

function y = g(x, w)
    y = sign(w'*[1;x]);
end