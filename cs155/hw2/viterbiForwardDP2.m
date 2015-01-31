%% Computes most likely state sequence resulting in observed outputs
% (Viterbi) while also finding the probability the HMM will produce the
% sequence (forward).
%
% X is observed sequence, T is state transition matrix, O is output emission
% matrix. For T and O the current states are specified along the rows while
% the next state/outputs are specified along the columns.
function stateSeq = viterbiForwardDP2(X,T,O)

nStates = size(T,1);
L = length(X);
V = zeros(nStates,L); % Store probabilities (Viterbi).
seq = cell(1,nStates); % Best state sequence for each end state.

for i = 1:L % Index of sequence
    obsIdx = X(i)+1; % Index of this observation
    if i == 1 % Base case for sequence length 1
        for s = 1:nStates
            p = 1/nStates; % Assume uniform prob of starting in each state.
            V(s,1) = log(O(s,obsIdx)*p); % Logs to prevent over/underflow.
            seq{s} = s;
        end
    else % For sequence length > 1
        % Compute probabilities from each possible previous state. Taking
        % the max (for Viterbi) and the sum (for Forward).
        for s = 1:nStates
            Vtemp = zeros(1,nStates); % Viterbi for each previous state.
            for sPrev = 1:nStates % Find max and sum
                Vtemp(sPrev) = log(O(s,obsIdx)*T(sPrev,s))+V(sPrev,i-1);
            end
            V(s,i) = max(Vtemp);
        end
    end
end

% For final answer, return max for Viterbi, or sum for Forward.
[~,stateSeq] = max(V);
