function [x, f, conv] = findzero_handle(fh, dfh, x0)
    steps = 0;
    x = x0;
    re = 1e-8;
    myrel = 1;
    while (myrel > re && steps < 20)
        xold = x;
        x = x - feval(fh,x)/feval(dfh,x);
        steps = steps + 1;
        myrel = abs((x - xold)/x);
    end
    
    if (myrel <= re)
        conv = 1;
    else
        conv = 0;
    end
    f = feval(fh,x);
end