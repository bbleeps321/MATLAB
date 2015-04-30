function [U,V,obj] = matrixFactorization2(Y,U,V,K,steps,stepsize,lambda)
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

obj = []; % For tracking error.
a = zeros(NumUsers,1);
b = zeros(1,NumMovies);

% Find the indices of the entries that aren't missing (aren't 0).
[ii,jj] = find(Y);
NumRatings = length(ii);

% Do stochastic gradient descent
for step = 1:steps
%     idx = randperm(NumRatings);
    
    % Create 3d matrix
    U3d = zeros(NumUsers,NumMovies,NumRatings);
    fprintf('a');
    for k = 1:NumRatings
        i = ii(k);
        j = jj(k);
        U3d = repmat(U(i,:),NumMovies,1);
        V3d = repmat(V(j,:),NumUsers,1);        
    end
    fprintf('b');
    
    % Update step
    mu = mean(Y(:));
    eij = (Y-mu) - (U*V'+repmat(a,1,NumMovies)+repmat(b,NumUsers,1));
    U = U + stepsize*(2*eij*sum(V3d,3)-lambda*U);
    V = V + stepsize*(2*eij*sum(U3d,3)-lambda*V);
    a(i) = a(i) + stepsize*(2*eij*-1);
    b(j) = b(j) + stepsize*(2*eij*-1);
    fprintf('c\n');

%     ct = 0;
%     for k = idx
%         fprintf('%d\n',ct);
%         i = ii(k);
%         j = jj(k);
%         
%         mu = mean(Y(:));
% 
%         % Compute differential        
%         eij = (Y(i,j)-mu) - (U(i,:)*V(j,:)' + a(i) + b(j));
% 
%         % Update
%         U(i,:) = U(i,:) + stepsize*(2*eij*V(j,:));
%         V(j,:) = V(j,:) + stepsize*(2*eij*U(i,:));
%         a(i) = a(i) + stepsize*(2*eij*-1);
%         b(j) = b(j) + stepsize*(2*eij*-1);
%         if rem(find(idx,k),100) == 0
%             U = U - lambda*U/length(ii)*100;
%             V = V - lambda*V/length(ii)*100;
%             a = a - lambda*a/length(ii)*100;
%             b = b - lambda*b/length(ii)*100;
%         end
%         ct = ct+1;
%     end
%     fprintf('.\n');
    
    % Get error for stopping condition
    obj(step) = 0;
    for k = idx
        i = ii(k);
        j = jj(k);
        obj(step) = obj(step) + (Y(i,j)-U(i,:)*V(j,:)').^2 + (lambda/2)*sum(U(i,:).^2+V(j,:).^2);
    end
%     if rem(step,floor(steps/10))==0
%         fprintf('e=%f\n',obj(step));
%     end
%     
%     if obj(step) < 0.1
%         break;
%     end    
%     
%     if step > 2
%         errChange = abs(obj(step-1)-obj(step))/obj(step-1);
%         if errChange < 1e-8
%             break;
%         end
%     end
end

if step == steps
    warning('Reached maximum step count');
end