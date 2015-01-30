%% Construct phi2 (transition vector).
function p2 = phi2(y,yprev,nStates)

p2 = zeros((nStates+1)^2,1);
p2((y-1)*(nStates+1) + yprev) = 1;