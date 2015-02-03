%% Load data
data = readRon();

%% EM step
[A,O] = trainHMM(data.mood,data.genre)

% Test
ypredHMM = viterbiDP(data.genre-1,A,O);
mean(ypredHMM==data.mood')

%% Train on first 4/5, test on final 5th.
partIdx = floor(4/5*length(data.mood));
[A,O] = trainHMM(data.mood(1:partIdx),data.genre(1:partIdx))
ypredHMMIn = viterbiDP(data.genre(1:partIdx)-1,A,O);
mean(ypredHMMIn == data.mood(1:partIdx)')
ypredHMMOut = viterbiDP(data.genre(partIdx+1:end)-1,A,O);
mean(ypredHMMOut == data.mood(partIdx+1:end)')