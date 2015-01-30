function p = constructPhi1(states,obs)

nObs = length(obs);
nStates = max(states);
nObsTypes = max(obs);

p = zeros((nStates+1)*nObsTypes,nObs);
for i = 1:nObs
    x = obs(i);
    y = states(i)+1; % State 1 is Start
    
    % Compute p1, setting index matching state y, observation x to 1.
    p((y-2)*nStates + x,i) = 1; % Set directly
end