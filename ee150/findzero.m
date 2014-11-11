% Find the zero using Newton's method.
% Finds the zero nearest to an initial guess.
% The function y must be given as a string.
% If the number of iterations exceeds 20, the function
% will assume there are no zeros in the vicinity of the guess.
function zero = findzero(y, dy, x)
    myf = inline(y);
    mydf = inline(dy);
    
    steps = 0;
    re = 1e-5;  % relative error
    myrel = 1;
    while (myrel > re && steps < 20)
        xold = x;
        x = x - myf(x)/mydf(x);
        steps = steps+1;
        myrel = abs((x - xold)/x);
    end
    if (myrel <= re)
        zero = x;
    else
        fprintf('ERROR: Zero not found!');
        zero = NaN;
    end
end