function [U,V] = matrixFactorization(Y,steps,lambda,eta)
%% Does matrix factorization using gradient descent.
%   Y is the matrix to factor. Can specify how many steps, the
%   regularization parameter, and the step size.

% Default values.
if nargin < 2
    steps = 5000;
end
if nargin < 3
    lambda = .0002;
end
if nargin < 4
    eta = 0.02;
end
NumUsers = size(Y,1);
NumMovies = size(Y,2);
U = rand(NumUsers,k);
V = rand(NumMovies,k);
% U = 2*rand(NumUsers,k)-1;
% V = 2*rand(NumMovies,k)-1;
for step = 1:steps
        % Compute differential
        for i = 1:NumUsers
            for j = 1:NumMovies
                if Y(i,j) > 0
                    eij = R[i][j] - numpy.dot(P[i,:],Q[:,j])
                    for k in xrange(K):
                        P[i][k] = P[i][k] + alpha * (2 * eij * Q[k][j] - beta * P[i][k])
                        Q[k][j] = Q[k][j] + alpha * (2 * eij * P[i][k] - beta * Q[k][j])
        eR = numpy.dot(P,Q)
        e = 0
        for i in xrange(len(R)):
            for j in xrange(len(R[i])):
                if R[i][j] > 0:
                    e = e + pow(R[i][j] - numpy.dot(P[i,:],Q[:,j]), 2)
                    for k in xrange(K):
                        e = e + (beta/2) * ( pow(P[i][k],2) + pow(Q[k][j],2) )
        if e < 0.001:
            break