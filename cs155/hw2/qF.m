%% Load data
data = readRon();

%% Train CRM with all data.
trainCRM(data.mood,data.genre);

%% EM step with 5-fold CV
partIdx = [1,438;...
           439,2*438;...
           2*438+1,3*438;...
           3*438+1,4*438;...
           4*438+1,data.N];
for i = 1:5
    idx = partIdx(i,1):partIdx(i,2);
    testIdx = zeros(1,data.N);
    testIdx(idx) = ones(1,length(idx));
    testIdx = 1:data.N .* testIdx;
    trainIdx = 1:data.N .* ~testIdx;
    moodTs = data.mood(testIdx);
    genreTs = data.genre(testIdx);
    moodTr = data.mood(~testIdx);
    genreTr = data.genre(~testIdx);
    
    [A,O] = trainHMM(moodTr,genreTr);
end