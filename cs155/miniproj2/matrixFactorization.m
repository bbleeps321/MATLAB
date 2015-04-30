function [U,V,err] = matrixFactorization(Y,U,V,K,steps,stepsize,lambda)
%% Does matrix factorization using gradient descent.
%   Y is the matrix to factor. Can specify how many steps, the
%   regularization parameter, and the step size.

% Default values.
if nargin < 5
    steps = 5000;
end
if nargin < 6
    stepsize = .0002;
end
if nargin < 7
    lambda = 0.02;
end
NumUsers = size(Y,1);
NumMovies = size(Y,2);

err = []; % For tracking error.

% Find the indices of the entries that aren't missing (aren't 0).
[ii,jj] = find(Y);

% Do stochastic gradient descent
for step = 1:steps
    idx = randperm(length(ii));
    
    % Update step
    for k = idx
        i = ii(k);
        j = jj(k);

        % Compute differential
        eij = Y(i,j) - U(i,:)*V(j,:)';

        % Update
        U(i,:) = U(i,:) + stepsize*(2*eij*V(j,:) - lambda*U(i,:));
        V(j,:) = V(j,:) + stepsize*(2*eij*U(i,:) - lambda*V(j,:));
    end
    
    % Get error for stopping condition
    err(step) = 0;
    for k = idx
        i = ii(k);
        j = jj(k);
        err(step) = err(step) + (Y(i,j)-U(i,:)*V(j,:)').^2 + (lambda/2)*sum(U(i,:).^2+V(j,:).^2);
    end
    if rem(step,floor(steps/10))
        fprintf('e=%f\n',err(step));
    end
    
    if err(step) < 0.1
        break;
    end    
    
    if step > 2
        errChange = abs(err(step-1)-err(step))/err(step-1);
        if errChange < 1e-8
            break;
        end
    end
end

if step == steps
    warning('Reached maximum step count');
end