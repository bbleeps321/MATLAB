function hw5_8
    N = 100; Eout = 0; epochs = 0;
    for (i = 1:N)
        [Etrial epochsTrial] = trial;
        Eout = Eout + Etrial;
        epochs = epochs + epochsTrial;
    end
    Eout = Eout/N
    epochs = epochs/N
end
function [Eout,epochs] = trial
    eta = .01; N = 100;
    % Pick random target function f by defining random line points.
    p = 2*rand(2,2) - 1;
    line = fliplr(polyfit(p(1,:),p(2,:),1));
    f = @(x) 2*(x(2,:) > line*[ones(1,size(x,2));x(1,:)])-1;
    x = 2*rand(2,N) - 1;    % Training data.
    y = f(x);
    X = [ones(1,N);x];
    
    epochs = 0;
    w = zeros(3,1);
    wlast = ones(3,1);
  
    while (norm(w-wlast) > .01)
        perm = randperm(N);
        wlast = w;
        for (i = 1:N)
            e = -y(perm(i))*X(:,perm(i))/(1+exp(y(perm(i))*w'*X(:,perm(i))));
            w = w - eta*e;
        end;
        epochs = epochs+1;
    end
    
    xout = 2*rand(2,N*10) - 1;
    yout = f(xout);
    Eout = sum(log(1+exp(-yout.*(w'*[ones(1,size(xout,2));xout]))))/(N*10);
end