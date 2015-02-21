function D = processRawData(rawfile,newfile, labeled);
% raw wc
M = csvread(rawfile,1,0);
N = size(M,1); % Number of (training) features.
D = zeros(size(M));

ids = M(:,1);
if labeled
    X = M(:,2:end-1);
    y = M(:,end);
else
    X = M(:,2:end);
end

% Find distribution of word counts, set data point according to z-score.
meanX = mean(X);
meanX = repmat(meanX,N,1);
stdX = std(X);
stdX = repmat(stdX,N,1);

zScores = (X-meanX)./stdX;

D(:,1) = ids;

if labeled
    D(:,2:end-1) = zScores;
    D(:,end) = y;
else
    D(:,2:end) = zScores;
end

save(newfile,'D');


% training set
% dataTr.ids = M(:,1);
% dataTr.X = M(:,2:end-1);
% dataTr.y = M(:,end);


% 
% % test set
% M = csvread('kaggle_test_wc.csv',1,0);
% dataTs.ids = M(:,1);
% dataTs.X = M(:,2:end);