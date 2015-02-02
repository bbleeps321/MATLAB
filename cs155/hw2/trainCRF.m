function w = trainCRM(states,obs)

lambda = 1e-5;
nObs = length(obs);
nStates = max(states);
nObsTypes = max(obs);

% Create the feature vectors phi1 (each column is a feature)
% phi1 = constructPhi1(states,obs);

%% Perform gradient descent.

% Random initial weights (positive and negative).
w = zeros((nStates)*nObsTypes+(nStates+1)^2,1);
count = 0;

while count < 10;
    % Compute G's and also Z(w).
    G = constructG(w,obs,nStates);
    
    % Compute alpha (forward).
    for j = 1:nObs
        if j == 1
            alpha(:,j) = zeros(nStates+1,1);
            alpha(1,j) = 1; % index 1 is start state.
        else
            alpha(:,j) = G{j}*alpha(:,j-1);
            Cj = sum(alpha(:,j-1)'*G{j});
            alpha(:,j) = alpha(:,j-1)/Cj;
        end        
    end

    % Compute beta (backward).
    for j = nObs:-1:1
        if j == nObs
            beta(:,j) = ones(nStates+1,1);
        else
            beta(:,j) = G{j+1}'*beta(:,j+1);
            Cj = sum(G{j+1}'*beta(:,j+1));
            beta(:,j) = beta(:,j+1)/Cj;
        end        
    end
    
    %% Compute gradient and apply step.
    
    % dF
    y = states + 1; % State 1 is start state so add 1
    yprev = [0; states(1:end-1)] + 1;
    dF = sum([phi1(y,obs,nStates,nObsTypes); phi2(y,yprev,nStates)],2);
    
    % dZw
    dZw = 0;
    % Pairwise combinations of a and b
    for j = 2:nObs        
        denom = sum(alpha(:,j-1)'*G{j}*beta(:,j));

        for a = 2:nStates+1
            bEnd = nStates + 1;
            for b = 1:bEnd
                phi = [phi1(a,obs(j),nStates,nObsTypes); phi2(a,b,nStates)];
                dZw = dZw + alpha(a,j-1)*G{j}(a,b)*beta(b,j)/denom * phi;
            end
        end
    end
    
    dw = -dF + dZw;    
    w = w - lambda*(dw);
    
    count = count + 1;
    
    % Print out dw size just to keep track of progress.
    if mod(count,5) == 0
        fprintf('%f\n',norm(dw));
    end
end

%% Calculate Gj.
function G = constructG(w,obs,nStates)
nObs = length(obs);
nObsTypes = max(obs);
G = cell(1,nObs);

for j = 1:nObs
    if j == 1
        phi_j = zeros((nStates)*nObsTypes+(nStates+1)^2,nStates+1);
        for a = 2:nStates+1
            p1 = phi1(a,obs(j),nStates,nObsTypes);
            phi_j(:,a) = [p1; phi2(a,1,nStates)];
        end
        G{j} = exp(w'*phi_j)'; % Make column vector.
    else
        % prev state in columns, next state in rows : yes
        G{j} = zeros(nStates+1,nStates+1);
        for a = 2:nStates+1
            p1 = phi1(a,obs(j),nStates,nObsTypes);
            for b = 1:nStates+1
                G{j}(a-1,b) = exp(w'*[p1;phi2(a,b,nStates)]);
            end
        end
    end
end
