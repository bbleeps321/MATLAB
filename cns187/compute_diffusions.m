function [Z] = compute_diffusions(X,MODEL,PARAMS)
% X - action potentials
% LAMBDA = firing rate of neurons when C=0 and when C=1
% C = inferred class of each spike raster
% Z = diffusion for each spike raster

%% compute_diffusions.m
% (c) California Institute of Technology
% P. Perona - 16 October, 2013
%

METHOD = 'POISSON';

[N,N_NEURONS,B,N_CONDITIONS] = size(X);
if N_CONDITIONS ~= 2, error('Can only deal with 2 conditions'); end;

[N_CONDITIONS_LAMBDA,N_NEURONS_LAMBDA] = size(MODEL.LAMBDA);
if N_CONDITIONS_LAMBDA ~= 2, error('Can only deal with 2 conditions'); end;
if N_NEURONS ~= N_NEURONS_LAMBDA, error('Dimensions mismatch between X and LAMBDA'); end;

Z = zeros(N,B,N_CONDITIONS);

for i_c = 1:N_CONDITIONS,
    for i_n = 1:N_NEURONS,
        
        %X(:,i_n,:,i_c) = XX(:,i_n,:,i_c)<p(i_c,i_n);
        
        LAMBDA0 = MODEL.LAMBDA(1,i_n);
        LAMBDA1 = MODEL.LAMBDA(2,i_n);
        
        switch METHOD
            case 'POISSON',
                w0 = log10(exp(1)) * (LAMBDA0-LAMBDA1)*PARAMS.DT;
                w1 = log10(LAMBDA1/LAMBDA0);
                
                Y = w0*ones(N,B);
                %Y = w0 * ones(size(X(:,i_n,:,i_c)));
                Y(squeeze(X(:,i_n,:,i_c))==1) = Y(squeeze(X(:,i_n,:,i_c))==1) + w1;
            case 'BERNOULLI',
                
                % Probability of a spike being observed in a given bin
                p0 = LAMBDA0*PARAMS.DT;
                p1 = LAMBDA1*PARAMS.DT;
                
                
                if  max(p0,p1) > 0.1,
                    fprintf(1,'Warning: multi-spike probability in a bin is %f\n', max(p0,p1)^2);
                end
                
                w0 = log10((1-p1)/(1-p0)); % increment of diffusion when no action potential is observed
                w1 = log10(p1/p0); % increment of diffusion when one action potential is observed
                
                Y = zeros(N,B);
                
                Y(squeeze(X(:,i_n,:,i_c))==0) = w0;
                Y(squeeze(X(:,i_n,:,i_c))==1) = w1;
                
            otherwise,
                error('Diffusion method not recognized');
        end;
        
        
        Z(:,:,i_c) = Z(:,:,i_c) + cumsum(Y,2); % compute the diffusions
    end;
end


if PARAMS.DEBUG>1,
    %%
    T0 = MODEL.T(1);
    T1 = MODEL.T(2);
    
    figure(100); clf;
    
        for i_c = 1:N_CONDITIONS,
            subplot(1,N_CONDITIONS,i_c);
            plot(squeeze(Z(1:10,:,i_c))'); hold on
            title(['Diffusions for neuron ' num2str(i_n) ' and condition ' num2str(i_c)]); ylim([2*T0 2*T1]);
        end;
    
end;