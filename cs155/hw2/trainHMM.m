function [A,O]=trainHMM(states,obs)

nObs = length(obs);
nStates = max(states);
nObsTypes = max(obs);

% First count number of observations in each state.
stateCounts = zeros(1,nStates);
for i = 1:nStates
    stateCounts(i) = sum(states==i);
end

% Transition matrix
A = zeros(nStates,nStates);
for i = 2:nObs
    yprev = states(i-1);
    y = states(i);
    A(yprev,y) = A(yprev,y)+1/stateCounts(yprev);
end

% for i = 1:nStates
%     A(i,:) = A(i,:)/sum(A(i,:));
% end

% Output emission matrix
O = zeros(nStates,nObsTypes);
for i = 1:nObs
    O(states(i),obs(i)) = O(states(i),obs(i)) + 1/stateCounts(states(i));
end

% for i = 1:nStates
%     O(i,:) = O(i,:)/sum(O(i,:));
% end
