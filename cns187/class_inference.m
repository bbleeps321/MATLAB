function [C,RT,N_AP] = class_inference(X,Z,MODEL,PARAMS)
%% class_inference.m
% (c) California Institute of Technology
% P. Perona - 16 October, 2013
%
T0 = MODEL.T(1);
T1 = MODEL.T(2);

[N,B,N_CONDITIONS] = size(Z);


i_D0 = zeros(N,N_CONDITIONS);
i_D1 = zeros(N,N_CONDITIONS);
C = zeros(N,N_CONDITIONS);
RT = zeros(N,N_CONDITIONS);
N_AP = zeros(N,N_CONDITIONS);


for i_c = 1:N_CONDITIONS,
    Z_c = squeeze(Z(:,:,i_c)); %% local copy of Z, specific to the condition
    Z_final = Z_c(:,end); %% final value of the diffusions
    Z_final = sign(Z_final) * max(-T0,T1)*2; % take a decision based on the sign of the diffusion
    Z_c(:,end) = Z_final;
    
    % put in one last dummy value 
    % in order to ensure at least one crossing on each side 
    % and make both i_D0 and i_D1 values be non-empty below
    Z_c(:,end+1) = -Z_final; 
    
    for i=1:N, %% Loop over all the instances
        i_D0(i) = find(Z_c(i,:)<T0,1,'first'); %% first crossing of neg. threshold
        i_D1(i) = find(Z_c(i,:)>T1,1,'first'); %% first crossing of pos. threshold
        
        if i_D0(i)<i_D1(i), % if the T0 thresh is crossed first
            C(i,i_c)=0;
            RT(i,i_c) = i_D0(i);
        else
            C(i,i_c)=1;
            RT(i,i_c) = i_D1(i);
        end
        
        X_c = squeeze(X(i,:,1:RT(i,i_c),i_c)); %% neuronal spike trains that participated in the decision
        N_AP(i,i_c) = sum(X_c(:)); % number of action potentials that were involved in the decision
    end
    
end

RT = RT *PARAMS.DT; %transform from bin index to time
