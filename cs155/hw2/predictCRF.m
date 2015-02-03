% Predict state sequence for CRFM.
function ypred = predictCRF(w,obs,nStates)

nObs = length(obs);
nObsTypes = max(obs);

% Viterbi algorithm for most likely path.
V = zeros(nStates,nObs); % Store probabilities (Viterbi).
for j = 1:nObs % Index of sequence
    if j == 1 % Base case for sequence length 1
        for s = 2:(nStates+1)
            phi = [phi1(s,obs(j),nStates,nObsTypes); phi2(s,1,nStates)];
            V(s-1,j) = log(w'*phi);
        end
    else % For sequence length > 1
        % Compute probabilities from each possible previous state. Taking
        % the max (for Viterbi).
        for s = 2:(nStates+1)
            Vtemp = zeros(1,nStates); % Viterbi for each previous state.
            p1 = phi1(s,obs(j),nStates,nObsTypes);
            for sprev = 2:nStates+1 % Find max and sum
                phi = [p1; phi2(s,sprev,nStates)];
                Vtemp(sprev-1) = log(w'*phi)+V(sprev-1,j-1);
            end
            V(s-1,j) = max(Vtemp);
        end
    end
end

% For final answer, return max for Viterbi.
[~,ypred] = max(V);