% Calculate integral of some function using trapezoid rule.
% Arguments: function handle, left endpoint, right endpoint, h

function y = trap(fn, a, b, h)
    n = (b-a)/h;
    x = a + [1:n-1]*h;
    y = sum(feval(fn,x));
    y = (h/2) * (feval(fn,a) + feval(fn,b) + 2*y);
end