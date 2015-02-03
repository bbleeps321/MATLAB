%% Load data
data = readRon();

%% Train CRM with all data.
tic;
w = trainCRF(data.mood,data.genre);
toc;
save('resultsCRMNew4','w');

% Test
ypredCRF = predictCRF(w,data.genre,4);
mean(ypredCRF == data.mood')

%% Train on first 4/5, test on final 5th.
NStates = 4;
partIdx = floor(4/5*length(data.mood));
tic;
w = trainCRF(data.mood(1:partIdx),data.genre(1:partIdx));
toc;
ypredCRFIn = predictCRF(w,data.genre(1:partIdx),NStates);
mean(ypredCRFIn == data.mood(1:partIdx)')
ypredCRFOut = predictCRF(w,data.genre(partIdx+1:end),NStates);
mean(ypredCRFOut == data.mood(partIdx+1:end)')
save('resultsCRM','w');