%% Load data
data = readRon();

%% Train CRM with all data.
tic;
w = trainCRM(data.mood,data.genre);
toc;
comment = 'New setup, denom = 1? (not 25). SLower calc of dZw. No a=0 in phi1';
save('resultsCRMNew4','w','comment');

% Test
ypredCRM = predictCRM(w,data.genre,4);
mean(ypredCRM == data.mood')

%%
NStates = 4;
partIdx = floor(4/5*length(data.mood));
tic;
w = trainCRM(data.mood(1:partIdx),data.genre(1:partIdx));
toc;
ypredCRMIn = predictCRM(w,data.genre(1:partIdx),NStates);
mean(ypredCRMIn == data.mood(1:partIdx)')
ypredCRMOut = predictCRM(w,data.genre(partIdx+1:end),NStates);
mean(ypredCRMOut == data.mood(partIdx+1:end)')
comment = 'Works! Train on first 4/5 of data.';
save('resultsCRM','w','comment');