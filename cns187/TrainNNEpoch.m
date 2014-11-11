% Trains a neural network with specified architecture and training set
% using standard backpropagation method. Number of nodes at each level does
% should not include the bias unit. Can also specify learning rate and
% number of iterations to train for (K).
% Returns the weights at each layer and the error on the training set.
function [W,x] = TrainNNEpoch(nodesPerLayer,Xtr,ytr,lambda,K)
tic;
% Initialize weights randomly.
nLayers = length(nodesPerLayer);
N = length(ytr);
W = cell(1,nLayers);
h = waitbar(0,'Training Network...');
for i = 1:nLayers
    Nin = 1+nodesPerLayer(i);
    if i == nLayers
        Nout = 1;
    else
        Nout = nodesPerLayer(i+1);
    end
    W{i+1} = rand(Nout,Nin);
end

for k = 1:K % Up to K iterations
    x = cell(1,nLayers);
    x{1} = Xtr;%(:,randperm(size(Xtr,2)));
    s = cell(1,nLayers-1);
    % Propagate forward.
    for i = 2:nLayers
        s{i-1} = W{i}*[ones(1,size(x{i-1},2));x{i-1}];
        x{i} = 1./(1+exp(-s{i-1}));
    end

    % Propagate back (first layer is special case) to get DLDW
    d = cell(1,nLayers-1);
%     DLDW = cell(1,nLayers-1);
%     gdot = x{nLayers}(1-x.*{nLayers});
%     d{end} = 2*(x{nLayers}-ytr).*gdot
    for i = nLayers:-1:2
        
        if i == nLayers % Special case for last layer.
%             gdot = x{i-1}.*(1-x{i-1});
            xAug = [ones(1,size(x{i-1},2));x{i-1}];
            gdot = x{i}.*(1-x{i});
            d{i} = (2*(x{i}-ytr).*gdot)';
            DLDW = (xAug.*repmat(d{i}',size(xAug,1),1))';
            W{i} = W{i} - lambda*sum(DLDW);
        else
            xAug = [ones(1,size(x{i-1},2));x{i-1}];
            xAugI = [ones(1,size(x{i},2));x{i}];
            gdot = xAugI.*(1-xAugI);

            d{i} = (d{i+1}*W{i+1}).*(gdot');
            d{i} = d{i}(:,2:end); % Remove bias delta.
            DLDW = (xAug*d{i})';
            W{i} = W{i} - lambda*DLDW;
            
            if all(all(abs(DLDW) < 1e-3))
                close(h);
                toc;
                return;
            end
        end
    end
    
    waitbar(k/K,h,'Training Network...');
end
close(h);
toc;
% catch
% keyboard;
% end