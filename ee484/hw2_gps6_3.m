clear; close all;

% Position matrix of satellite, each satellite on one row.
X = [3.00 9.53; 8.41 8.65; -1.23 6.99]';

% Measured pseudoranges.
Rc = [1.19 3.71 -1.71]';
% Rc = [101.19 103.71 98.29]';


x0 = [0; 0];     % Initial guess at origin with 0 bias.
b0 = 0;
lastGuess = [-100 -100 -100]';

% i = 1;
% error = 0;
while (norm([x0;b0]-lastGuess) > .0001)
    % Calculate estimated pseudoranges.
    R0 = pseudorange(x0,b0,X);
    dR = Rc - R0;

    % Calculate G matrix
    G = makeG(X,x0);

    % Solve for dx and db
    dX = inv(G'*G)*G'*dR;
    dX(1) = 0;  % can't change x coordinate.

    % Update
    lastGuess = [x0; b0];
    x0 = x0+dX(1:size(X,1));
    b0 = b0+dX(end);
    
%     error(i) = norm([x0;b0]-lastGuess);
%     i = i+1;
    
end

% plot(1:length(error),error);
% title('RMS error in position and bias estimate');
% xlabel('Iteration'); ylabel('RMS Error');

x0
b0