% Predict state sequence for CRM.
function ypred = predictCRM(w,states,obs)

nObs = length(obs);
nStates = max(states);
nObsTypes = max(obs);

% Create the feature vectors phi1 (each column is a feature)
phi1 = constructPhi1(states,obs);

% Viterbi algorithm for most likely path.
seq = cell(1,nStates); % Best state sequence for each end state.
V = zeros(nStates,nObs); % Store probabilities (Viterbi).
for j = 1:nObs % Index of sequence
    if j == 1 % Base case for sequence length 1
        for s = 2:(nStates+1)
            phi = [phi1(:,j); phi2(s,1,nStates)];
            V(s-1,1) = w'*phi;
%             V(s-1,1) = log(w'*phi);
            seq{s-1} = s;
        end
    else % For sequence length > 1
        % Compute probabilities from each possible previous state. Taking
        % the max (for Viterbi) and the sum (for Forward).
        for s = 2:(nStates+1)
            Vtemp = zeros(1,nStates); % Viterbi for each previous state.
            for sprev = 2:nStates+1 % Find max and sum
                phi = [phi1(:,j); phi2(s,sprev,nStates)];
                Vtemp(sprev-1) = w'*phi*V(sprev-1,j-1);
%                 Vtemp(sprev-1) = log(w'*phi)+V(sprev-1,j-1);
            end
%             Vtemp = Vtemp/max(abs(Vtemp));
            [V(s-1,j),bestState] = max(Vtemp);
            seq{s-1} = [seq{s-1} bestState+1];
        end
    end
end

% For final answer, return max for Viterbi, or sum for Forward.
[~,bestEndState] = max(V(:,end));
ypred = seq{bestEndState};