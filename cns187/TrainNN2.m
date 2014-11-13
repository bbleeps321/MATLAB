% Trains a neural network with specified architecture and training set
% using standard backpropagation method. Number of nodes at each level does
% should not include the bias unit. Can also specify learning rate and
% number of iterations to train for (K).
% Returns the weights at each layer and the error on the training set.
function [W,x,L] = TrainNN2(nodesPerLayer,Xtr,ytr,lambda,K,samplesPerUpdate,mu)%,postIterationScript)
tic;
% Initialize weights randomly.
nLayers = length(nodesPerLayer);
N = length(ytr);
W = cell(1,nLayers-1);
h = waitbar(0,'Training Network...');

% Default args.
if exist('samplesPerUpdate','var')
    samplesPerUpdate = min(samplesPerUpdate,N);
else
    samplesPerUpdate = 1;
end
if ~exist('mu','var')
    mu = 0;
end

for i = 1:nLayers
    Nin = 1+nodesPerLayer(i);
    if i == nLayers
        Nout = 1;
    else
        Nout = nodesPerLayer(i+1);
    end
    W{i+1} = rand(Nout,Nin);
end
L = zeros(1,K);
for k = 1:K % Up to K iterations/updates
    idx = randperm(size(Xtr,2),samplesPerUpdate);
    % Propagate forward.
    [~,x] = ComputeNN(W,Xtr(:,idx));

    % Propagate back (first layer is special case) to get DLDW
    d = cell(1,nLayers-1);
    for i = nLayers:-1:2
        
        if i == nLayers % Special case for last layer.
            xAug = [ones(1,size(x{i-1},2));x{i-1}];
            gdot = x{i}.*(1-x{i});
            d{i} = (2*(x{i}-ytr(idx)).*gdot)';
            DLDW = (xAug.*repmat(d{i}',size(xAug,1),1))';
            W{i} = W{i} - lambda*(sum(DLDW) + mu*sign(W{i}));
        else
            xAug = [ones(1,size(x{i-1},2));x{i-1}];
            xAugI = [ones(1,size(x{i},2));x{i}];
            gdot = xAugI.*(1-xAugI);

            d{i} = (d{i+1}*W{i+1}).*(gdot');
            d{i} = d{i}(:,2:end); % Remove bias delta.
            DLDW = (xAug*d{i})';
            W{i} = W{i} - lambda*(DLDW + mu*sign(W{i}));
        end
    end
    L(k) = sum((x{end}-ytr(idx)).^2); % MSE
    % TODO: Num weights > some threshold
    
    waitbar(k/K,h,'Training Network...');
end
close(h);
toc;

L = L(1:find(L,1,'last'));
