%% Computes most likely state sequence resulting in observed outputs
% (Viterbi) while also finding the probability the HMM will produce the
% sequence (forward).
%
% X is observed sequence, T is state transition matrix, O is output emission
% matrix. For T and O the current states are specified along the rows while
% the next state/outputs are specified along the columns.
function [stateSeq,pTot] = viterbiForward(X,T,O)
global count;
count = 0;
nStates = size(T,1);
L = length(X);
p = zeros(1,nStates);
seq = zeros(nStates,L);
pTot = 0;
% Find 
for i = 1:nStates
    [p(i),seq(i,:),ptot,map] = viterbiFwdHelper(X,L,i,T,O,map);
    pTot = pTot + ptot;
end
[p,i] = max(p);
stateSeq = seq(i,:);
disp(count);

%% Recursive helper function. L is current length of sequence to look at
% and state is desired end state. Returns probability of state sequence
% and 
function [p,seq,pTot] = viterbiFwdHelper(X,L,state,T,O,map)
global count;
count = count + 1;
nStates = size(T,1);
if L == 1 % Base case
    % Assume initial state uniformly selected.
    obsIdx = X(1)+1; % Column index corresponding to observed output
    start = randi(nStates);
    p = O(start,obsIdx)*1/nStates;
    pTot = p;
    seq = state;
else % Recursive case
    p = zeros(1,nStates);
    seq = zeros(nStates,L-1);
    obsIdx = X(L)+1; % Column index corresponding to observed output
    pTot = 0;
    % Find most likely state sequence for subset.
    % Also sum up the probabilities.
    for i = 1:nStates
        [pTemp,seq(i,:),ptot] = viterbiFwdHelper(X,L-1,i,T,O,map);
        p(i) = O(state,obsIdx)*T(i,state)*pTemp;
        pTot = pTot + O(state,obsIdx)*T(i,state)*ptot;
    end
    [p,i] = max(p);
    seq = [seq(i,:) state]; % Save this state sequence
end