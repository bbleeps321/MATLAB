% Simulates associative net consistent with Marr's theory of the
% cerebellum. Uses a net with N input and output lines, sparsity s, and L
% number of patterns.
% 
% Optionally plots the results and also returns X, Y, and Ypred where X is
% an NxLmatrix of input patterns, Y is an NxL matrix of output patterns,
% and Ypred is an NxL matrix of output patterns predicted by the
% associative net.
% 
% Plots by default.
function [X Y Ypred] = simulateMarrNet(N,s,L,toPlot)
    if (nargin < 4)
        toPlot = 1;
    end
    % Generate input and output patterns (random)
    X = generatePattern(N,s,L);
    Y = generatePattern(N,s,L)';
    
    % Train weight matrix using X and Y.
    W = zeros(N,N);
    for (p = 1:L)
        for (i = 1:N)
            % Sets synaptic value to 1 if input and output at location are 1 or already 1.
            W(:,i) = (W(:,i) | (X(:,p) & Y(p,i)));
        end
    end

    % Get Ypred.
    thresh = N*s;
    % X'W sums activity along each output line.
    Ypred = double(X'*W >= thresh);
    
    % Optionally plot
    if (toPlot)
        subplot(3,1,1);
        pcolor(padarray(X',[1 1],'post'));
        title('X'); ylabel('Pattern');
        subplot(3,1,2);
        pcolor(padarray(Y,[1 1],'post'));
        title('Y'); ylabel('Pattern');
        subplot(3,1,3);
        pcolor(padarray(Ypred,[1 1],'post'));
        title('Ypred'); xlabel('Input/Output Line'); ylabel('Pattern');

        % Convert to B/W image
        colormap(gray(2));
    end
end

% Generates a random NxL matrix with the specified sparsity of ones.
% Each length L row will have a proportion s of ones and the rest as zeros.
function M = generatePattern(N,s,L)
    M = [ones(floor(N*s),L); zeros(ceil(N*(1-s)),L)];
    for (i = 1:L)
        M(:,i) = M(randperm(N),i);
    end
end