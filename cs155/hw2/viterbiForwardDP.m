%% Computes most likely state sequence resulting in observed outputs
% (Viterbi) while also finding the probability the HMM will produce the
% sequence (forward).
%
% X is observed sequence, T is state transition matrix, O is output emission
% matrix. For T and O the current states are specified along the rows while
% the next state/outputs are specified along the columns.
function [stateSeq,pTot] = viterbiForwardDP(X,T,O)

nStates = size(T,1);
L = length(X);
V = zeros(nStates,L); % Store probabilities (Viterbi).
P = zeros(nStates,L); % Store total probabilities (Forward).

for i = 1:L % Index of sequence
    obsIdx = X(i)+1; % Index of this observation
    if i == 1 % Base case for sequence length 1
        for s = 1:nStates
            p = 1/nStates; % Assume uniform prob of starting in each state.
            V(s,1) = O(s,obsIdx)*p;
            P(s,1) = O(s,obsIdx)*p;
        end
    else % For sequence length > 1
        % Compute probabilities from each possible previous state. Taking
        % the max (for Viterbi) and the sum (for Forward).
        for s = 1:nStates
            Vtemp = zeros(1,nStates); % Viterbi for each previous state.
            for sPrev = 1:nStates % Find max and sum
                Vtemp(sPrev) = O(s,obsIdx)*T(sPrev,s)*V(sPrev,i-1);
            end
            [V(s,i),bestState] = max(Vtemp);
            P(s,i) = sum(Vtemp);
        end
    end
end

% For final answer, return max for Viterbi, or sum for Forward.
[~,stateSeq] = max(V);
pTot = sum(P(:,end));
