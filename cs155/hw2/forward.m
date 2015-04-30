%% X is observed sequence, T is state transition matrix, O is output emission
% matrix. For T and O the current states are specified along the rows while
% the next state/outputs are specified along the columns.
function P = forward(X,T,O)

nStates = size(T,1);
L = length(X);
P = 0;
% Find total probability
for i = 1:nStates
    P = P + forwardHelper(X,L,i,T,O);
end

%% Recursive helper function. L is current length of sequence to look at
% and state is desired end state. Returns probability of state sequence
% and 
function p = forwardHelper(X,L,state,T,O)

nStates = size(T,1);
if L == 1 % Base case
    % Assume initial state uniformly selected.
    obsIdx = X(1)+1; % Column index corresponding to observed output
    start = randi(nStates);
    p = O(start,obsIdx)*1/nStates;
else % Recursive case
    obsIdx = X(L)+1; % Column index corresponding to observed output
    % Find total probability
    p = 0;
    for i = 1:nStates
        p = p + O(state,obsIdx)*T(i,state)*forwardHelper(X,L-1,i,T,O);
    end
end