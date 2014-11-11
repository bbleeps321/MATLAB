function X = generate_spike_trains(N,MODEL,PARAMS)
%% generate_spike_trains.m
% (c) California Institute of Technology
% P. Perona - 16 October, 2013
%


% assign values to the parameters
if nargin<1,
    N = 100;
end

if nargin <2,
    MODEL.LAMBDA = [1 10]'; %% spikes per second
end;

[N_CONDITIONS,N_NEURONS] = size(MODEL.LAMBDA);
if N_CONDITIONS ~= 2, error('Can only deal with 2 conditions'); end;

if nargin<2,
    PARAMS.DT = 0.001; %% in seconds
    PARAMS.T = 0.3; %% in seconds
    PARAMS.DEBUG = 2;
end

p = MODEL.LAMBDA*PARAMS.DT; % probability of an action potential being observed in a given bin

if  max(p(:))> 0.1,
    fprintf(1,'Warning: multi-spike probability in a bin is %f -- need to reduce bin size.\n', p.^2);
end

B = ceil(PARAMS.T/PARAMS.DT); % number of bins per spike train
XX = rand(N,N_NEURONS,B,N_CONDITIONS);
X = zeros(N,N_NEURONS,B,N_CONDITIONS);

for i_c = 1:N_CONDITIONS,
    for i_n = 1:N_NEURONS,
        X(:,i_n,:,i_c) = XX(:,i_n,:,i_c)<p(i_c,i_n);
    end;
end

if PARAMS.DEBUG>1,
    figure(101); clf
    SHOW_SEPARATELY_NEURONS_AND_CONDITIONS = 1;
    if SHOW_SEPARATELY_NEURONS_AND_CONDITIONS,
        
        for i_c = 1:N_CONDITIONS,
            for i_n = 1:N_NEURONS,
                subplot(N_NEURONS,N_CONDITIONS,sub2ind([N_CONDITIONS, N_NEURONS],i_c, i_n));
                imagesc(squeeze(-X(:,i_n,:,i_c))); colormap gray
                xlabel('Time (bins)');
                ylabel('Spike train index');
                title(['Neuron ' num2str(i_n) ', C=' num2str(i_c-1) ]);
            end;
        end
    else % show action potentials in single panel
        imagesc(-reshape(X,[N*N_NEURONS B*N_CONDITIONS]));
        colormap(gray);
        xlabel('Time (bins) x Neuron (index)');
        ylabel('Spike train index x condition');
        n_spikes = sum(X(:));
        n_bins = prod(size(X(:)));
        n_sec = n_bins * PARAMS.DT;
        spikes_per_sec = n_spikes /n_sec;
        title([num2str(n_spikes) ' in ' ...
            num2str(n_bins) ' bins. \lambda = ' ...
            num2str(spikes_per_sec) ' / s']);
    end
end;