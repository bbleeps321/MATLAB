% AR Recursive Least Squares implementation
% Adaptive Filtering
% a is vector a1 a2 of coefficients
% s2 is sigma of error squared
function project(a, s2)
    % Simulation section
    N = 200;    % number of simulations
    L = 256;    % length of signal
    
    e = zeros(N,L); % each trial a new row
    w = zeros(2,N); % each trial a new column. One weight per row
    w1 = zeros(N,L);
    w2 = zeros(N,L);

    for (i=1:N)
        [e(i,:) W] = rls(a,s2,L);
        w(:,i) = W(:,end);
        w1(i,:) = W(1,:);
        w2(i,:) = W(2,:);
    end
    mse = mean(e.^2,1);
    figure; plot(mse); title('Mean Error Squared'); xlabel('Iterations');
    axis([0 256 0 1]); axis 'auto y';
    figure; plot(mean(w1,1)); title('w1'); xlabel('Iterations');
    axis([0 256 0 1]); axis 'auto y';
    figure; plot(mean(w2,1)); title('w2'); xlabel('Iterations');    
    axis([0 256 0 1]); axis 'auto y';
    fprintf('Minimum MSE = %f\n', min(mse(end-50:end)));
    fprintf('Average w1 = %f\n', mean(mean(w(1,end-50:end))));
    fprintf('Average w2 = %f\n', mean(mean(w(2,end-50:end))));
    
    %--------------------------------------------------------------
    % Theoretical calculations
    fprintf('\n');
    disp('Theoretical:');
    
    r0 = (1+a(2))*s2/((1-a(2))*(1+a(2))^2-a(1)^2);
    r1 = -a(1)*r0/(1+a(2));
    r2 = (-a(2)+a(1)^2/(1+a(2)))*r0;
    R = [r0 r1; r1 r0];
    p = [r1; r2];
    wopt = R\p;
    disp('Optimal w:');
    disp(wopt);
    Jmin = r0 - p'*wopt;
    disp('Minimum Square Error:');
    disp(Jmin);
end

% Returns 3 vectors, 1 for error, and 1 for each of the 2 weights
function [e w] = rls(a,s2,L)
    lambda = 1;
    eps = 1e-5;
    
    v = randn(1,L)/sqrt(s2);
    % generate u
    % Note we do L+2 where u(3) matches t = 0. The first 2 values are just
    % initializing placeholders.
    u = zeros(1,L+2);
    for (i=3:L)
        u(i) = v(i) - a(1)*u(i-1) - a(2)*u(i-2);
    end
    
%     R = eps*eye(2);
    Z = eye(2)/eps; % = inv(R);
    e = zeros(1,L+2);
    w = zeros(2,L+2);
    for (i=3:L+2)
        x = [u(i-1) u(i-2)]';
        e(i) = u(i) - w(:,i-1)'*x;
        k = Z*x/(lambda + x'*Z*x);
        Z = (eye(2) - k*x')*Z/lambda;
        w(:,i) = w(:,i-1)+k*e(i);
    end
    e = e(3:end);
    w = w(:,3:end); % get rid of the placeholder indicies.
end
