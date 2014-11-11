function hw2_8
    K = 1000;
    Ein = 0;
    for (k = 1:K)
        Ein = trial;
    end
    fprintf('Ein=%f\n',Ein);
end

function Ein = trial
    N = 1000;
    x = 2*rand(N,2)-1;
    y = sign(x(:,1).^2 + x(:,2).^2 - .6);
    flip = randi(N,1,100);
    yNoise = y;
    yNoise(flip) = -1*yNoise(flip);
    
    
    X = [ones(N,1) x];
    w = (X'*X)\X'*yNoise;
    Ein = sum(yNoise' ~= sign(w'*X'))/N;
end