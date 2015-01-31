%% Construct phi2 (transition vector).
function p2 = phi2(y,yprev,nStates)

p2 = zeros((nStates+1)^2,length(y));
for j = 1:length(y)
    p2((y(j)-1)*(nStates+1) + yprev(j),j) = 1;
end