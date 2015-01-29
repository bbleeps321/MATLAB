function data = readData(file)

% Open file.
fid = fopen(file);
data.filename = file;

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

% Read output emission matrix.
O = zeros(nY,nX);
for i = 1:nY
    line = strtrim(fgetl(fid));
    O(i,:) = str2double(strsplit(line));
end
data.O = O;

% Read sequence.
seq = cell(1,5);
for i = 1:5
    line = strtrim(fgetl(fid));
    seq{i} = zeros(1,length(line));
    for j = 1:length(line)
        seq{i}(j) = str2double(line(j));
    end
end
data.seq = seq;
    
% Close file.
fclose(fid);