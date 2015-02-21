% Trains a neural network with specified architecture and training set
% using standard backpropagation method.
% Number of nodes at each level does not include input layer and also
% should not include the bias unit. Can also specify learning rate and
% number of iterations to train for (K).
% Returns the weights at each layer and the error on the training set.
function [W,x,accTr,accTs] = TrainNN2(nodesPerLayer,Xtr,ytr,lambda,K,optParams)
tic;
% Initialize weights randomly.
nodesPerLayer = [size(Xtr,1) nodesPerLayer]; % Add input layer size.
nLayers = length(nodesPerLayer);
N = length(ytr);
W = cell(1,nLayers-1);

showProgress = 1;
if exist('optParams','var') && isfield(optParams,'ShowProgress')
    showProgress = optParams.ShowProgress;
end

if showProgress
    h = waitbar(0,'Training Network...');
end

mu = 0;
if exist('optParams','var') && isfield(optParams,'mu')
    mu = optParams.mu;
end

for i = 1:nLayers-1
    Nin = 1+nodesPerLayer(i);
    Nout = nodesPerLayer(i+1);
    W{i+1} = 2*.05*rand(Nout,Nin)-.05;
end
accTr = zeros(1,K);

checkTestSet = 0;
if exist('optParams','var') && isfield(optParams,'Xts') && isfield(optParams,'yts')
    accTs = zeros(1,K);
    checkTestSet = 1;
end

for k = 1:K % Up to K iterations/updates
    idx = randperm(size(Xtr,2)); % Randomize sample orders.
    
    % Propagate forward.
    [~,x] = ComputeNN(W,Xtr(:,idx));

    % Propagate back (first layer is special case) to get DLDW
    d = cell(1,nLayers);
    for i = nLayers:-1:2
        
        if i == nLayers % Special case for last layer.
            xAug = [ones(1,size(x{i-1},2));x{i-1}];
            gdot = x{i}.*(1-x{i});
            d{i} = (2*(x{i}-ytr(idx)).*gdot)';
            DLDW = xAug.*repmat(d{i}',size(xAug,1),1);
            W{i} = W{i} - lambda*(sum(DLDW,2)' + mu*sign(W{i}));
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
    accTr(k) = 100*mean((x{end} > .5)==ytr(idx));
    
    if checkTestSet
        ypred = ComputeNN(W,optParams.Xts) > .5;
        accTs(k) = 100*mean(ypred==optParams.yts);
    end
    
    % TODO: Num weights > some threshold
    
    if showProgress
        waitbar(k/K,h,'Training Network...');

        % Print accuracy every 10 iterations.
        if mod(k,10) == 0
            if checkTestSet
                fprintf('Finished iteration: %d, accTr=%.2f%%, accTs=%.2f%%\n',k,accTr(k),accTs(k));
            else
                fprintf('Finished iteration: %d, accTr=%.2f%%\n',k,accTr(k));
            end
        end
    end
end

if showProgress
    close(h);
end
toc;

accTr = accTr(1:find(accTr,1,'last'));
