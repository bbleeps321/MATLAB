%% Construct phi1 (observation indicator vector).
function p1 = phi1(y,obs,nStates,nObsTypes)

nObs = length(obs);
p1 = zeros((nStates)*nObsTypes,nObs);

if any(y <= 1)
    error('Start state in observations?!');
end

for i = 1:nObs
    x = obs(i);

    % Compute p1, setting index matching state y and observation x to 1.
    p1((y(i)-2)*nStates + x,i) = 1; % Set directly
end