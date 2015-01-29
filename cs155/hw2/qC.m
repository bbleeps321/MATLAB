%% Load data.
data = cell(1,5);
for i = 1:5
    data{i} = readData(['sequenceprediction' num2str(i) '.txt']);
end

%% Calculate most probable state sequence and the probability the HMM will
% produce the given each sequence.
seq = cell(5,5);
P = zeros(5,5);
for i = 1:5
    fprintf('Dataset %d\n',i);
    for j = 1:5
        [seq{i,j},P(i,j)] = viterbiForwardDP(data{i}.seq{j},data{i}.T,data{i}.O);
        fprintf('Sequence %d:\n',j);
        disp(P(i,j));
        disp(seq{i,j});
    end
    fprintf('\n');
end