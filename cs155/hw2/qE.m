%% Load data
data = readRon();

%% EM step
[A,O] = trainHMM(data.mood,data.genre)


% Test
ypredHMM = viterbiForwardDP2(data.genre-1,A,O);
mean(ypredHMM==data.mood')

%%
partIdx = floor(4/5*length(data.mood));
[A,O] = trainHMM(data.mood(1:partIdx),data.genre(1:partIdx));
ypredHMMIn = viterbiForwardDP(data.genre(1:partIdx)-1,A,O);
mean(ypredHMMIn == data.mood(1:partIdx)')
ypredHMMOut = viterbiForwardDP(data.genre(partIdx+1:end)-1,A,O);
mean(ypredHMMOut == data.mood(partIdx+1:end)')
%% 5-fold CV for error estimate

% partIdx = [1,438;...
%            439,2*438;...
%            2*438+1,3*438;...
%            3*438+1,4*438;...
%            4*438+1,data.N];
% for i = 1:5
%     idx = partIdx(i,1):partIdx(i,2);
%     testIdx = zeros(1,data.N);
%     testIdx(idx) = ones(1,length(idx));
%     testIdx = 1:data.N .* testIdx;
%     trainIdx = 1:data.N .* ~testIdx;
%     moodTs = data.mood(testIdx);
%     genreTs = data.genre(testIdx);
%     moodTr = data.mood(~testIdx);
%     genreTr = data.genre(~testIdx);
%     
%     [A,O] = trainHMM(moodTr,genreTr);
% end