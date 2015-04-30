function [movieData,userData] = loadData()

%% Movie data
M = csvread('movies.txt');


% First line.
line = fgetl(fid);
tokens = strsplit(line);
nY = str2double(tokens(1)); % # states
nX = str2double(tokens(2)); % # observations
data.nY = nY;
data.nX = nX;

% Read transition matrix.
T = zeros(nY,nY);
for i = 1:nY
    line = strtrim(fgetl(fid));
    T(i,:) = str2double(strsplit(line));
end
data.T = T;