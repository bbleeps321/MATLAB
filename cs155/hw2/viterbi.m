%% X is observed sequence, T is state transition matrix, O is output emission
% matrix. For T and O the current states are specified along the rows while
% the next state/outputs are specified along the columns.
function stateSeq = viterbi(X,T,O)

nStates = size(T,1);
L = length(X);
p = zeros(1,nStates);
seq = zeros(nStates,L);
for i = 1:nStates
    [p(i),seq(i,:)] = viterbiHelper(X,L,i,T,O);
end
[p,i] = max(p);
stateSeq = seq(i,:);

%% Recursive helper function. L is current length of sequence to look at
% and state is desired end state. Returns probability of state sequence
% and 
function [p,seq] = viterbiHelper(X,L,state,T,O)

nStates = size(T,1);
if L == 1 % Base case
    % Assume initial state uniformly selected.
    obsIdx = X(1)+1; % Column index corresponding to observed output
    start = randi(nStates);
    p = O(start,obsIdx)*1/nStates;
    seq = state;
else % Recursive case
    p = zeros(1,nStates);
    seq = zeros(nStates,L-1);
    obsIdx = X(L)+1; % Column index corresponding to observed output
    % Find most likely state sequence for subset.
    for i = 1:nStates
        [pTemp,seq(i,:)] = viterbiHelper(X,L-1,i,T,O);
        p(i) = O(state,obsIdx)*T(i,state)*pTemp;
    end
    [p,i] = max(p);
    seq = [seq(i,:) state]; % Save this state sequence
end