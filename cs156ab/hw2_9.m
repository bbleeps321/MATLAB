function err = hw2_9
    N = 1000;
    x = 2*rand(N,2)-1;
    y = sign(x(:,1).^2 + x(:,2).^2 - .6);
    flip = randi(N,1,100);
    yNoise = y;
    yNoise(flip) = -1*yNoise(flip);
    
    X = [ones(N,1) x(:,1) x(:,2) x(:,1).*x(:,2) x(:,1).^2 x(:,2).^2];
    w = (X'*X)\X'*yNoise
    
    % Check against each option
    err = zeros(5,1);
    err(1) = sum(sign([-1 -.05 .08 .13 1.5 1.5]*X')~=sign(w'*X'))/N;
    err(2) = sum(sign([-1 -.05 .08 .13 1.5 15]*X')~=sign(w'*X'))/N;
    err(3) = sum(sign([-1 -.05 .08 .13 15 1.5]*X')~=sign(w'*X'))/N;
    err(4) = sum(sign([-1 -1.5 .08 .13 .05 .05]*X')~=sign(w'*X'))/N;
    err(5) = sum(sign([-1 -.05 .08 1.5 .15 .15]*X')~=sign(w'*X'))/N;
end