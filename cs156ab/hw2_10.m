function Eout = hw2_10
    K = 1000;
    Eout = 0;
    for (i=1:K)
        Eout = Eout + trial;
    end
    Eout = Eout/K;
    fprintf('Eout=%f\n',Eout);
end

function Eout=trial
    N = 1000;
    x = 2*rand(N,2)-1;
    y = sign(x(:,1).^2 + x(:,2).^2 - .6);
    flip = randi(N,1,100);
    yNoise = y;
    yNoise(flip) = -1*yNoise(flip);
    
    X = [ones(N,1) x(:,1) x(:,2) x(:,1).*x(:,2) x(:,1).^2 x(:,2).^2];
    w = (X'*X)\X'*yNoise;
    
    % Check against 1000 new points.
    Dtest = 2*rand(N,2)-1;
    Xtest = [ones(N,1) Dtest(:,1) Dtest(:,2) Dtest(:,1).*Dtest(:,2) Dtest(:,1).^2 Dtest(:,2).^2];
    ytest = sign(Dtest(:,1).^2 + Dtest(:,2).^2 - .6);
    flip = randi(N,1,100);
    ytest(flip) = -1*ytest(flip);
    Eout = sum(ytest'~=sign(w'*Xtest'))/N;
end