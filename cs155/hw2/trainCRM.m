function w = trainCRM(states,obs)

lambda = 1e-3;
nObs = length(obs);
nStates = max(states);
nObsTypes = max(obs);

% Create the feature vectors phi1 (each column is a feature)
phi1 = constructPhi1(states,obs);

%% Perform gradient descent.

% Random initial weights (positive and negative).
w = zeros((nStates)*nObsTypes+(nStates+1)^2,1);
dw = 1000;
count = 0;
while norm(dw) > 2
    % Compute G's and also Z(w).
    G = cell(1,nObs);
%     G_1M = 1; % Cumulative product of G's.
    for j = 1:nObs
        p1 = phi1(:,j);
        G{j} = Gj(j,w,p1,nStates);
%         G_1M = G{j}*G_1M;
    end
%     Zw = sum(G_1M);
    
    % Compute alpha (forward).
    for j = 1:nObs
        if j == 1
            alpha(:,j) = zeros(nStates+1,1);
            alpha(1,j) = 1; % index 1 is start state.
        else
            alpha(:,j) = G{j}*alpha(:,j-1);
            Cj = sum(alpha(:,j-1)'*G{j});
            alpha(:,j) = alpha(:,j)/Cj;
        end        
    end
    
    % Compute beta (backward).
    for j = nObs:-1:1
        if j == nObs
            beta(:,j) = ones(nStates+1,1);
        else
            beta(:,j) = G{j+1}'*beta(:,j+1);
            Cj = sum(G{j+1}'*beta(:,j+1));
            beta(:,j) = beta(:,j)/Cj;
        end        
    end

    % alpha [5 2191]
    % Compute gradient and apply step.
    dZw = 0;
    dF = 0;
    for j = 1:nObs
        % dF
        y = states(j) + 1; % State 1 is start state so add 1
        if j == 1
            yprev = 1; % start state.
        else
            yprev = states(j-1)+1;
        end
        dF = dF + [phi1(:,j); phi2(y,yprev,nStates)];
        
        % dZw
        denom = sum(alpha(:,j)'*G{j}*beta(:,j));
        for a = 1:nStates+1
            bEnd = nStates + 1;
            if j == 1 bEnd = 1; end;
            for b = 1:bEnd
                phi = [phi1(:,j); phi2(a,b,nStates)];
                % (G(b,a)?)
                dZw = dZw + alpha(a,j)*G{j}(a,b)*beta(b,j)/denom * phi;
            end
        end
    end
    
    dw = -dF + dZw;
    
    w = w - lambda*(-dF+dZw);
    
    count = count + 1;
    if mod(count,5) == 0
        fprintf('%f\n',norm(dw));
    end
%     dw = 0;
end

%% Calculate Gj.
function G = Gj(j,w,p1,nStates)
if j == 1
    phi_j = zeros(length(p1)+(nStates+1)^2,nStates+1);
    for a = 1:nStates+1
        phi_j(:,a) = [p1;phi2(a,1,nStates)];
    end
    G = exp(w'*phi_j)'; % Make column vector.
else
    % prev state in columns, next state in rows : yes
    G = zeros(nStates+1,nStates+1);
    for a = 1:nStates+1
        for b = 1:nStates+1
            G(a,b) = exp(w'*[p1;phi2(a,b,nStates)]);
        end
    end
end
