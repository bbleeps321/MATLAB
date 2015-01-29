function data = readRon()
N = 2191;

% Open file.
fid = fopen('ron.txt');
data.moodStr = cell(N,1);
data.mood = zeros(N,1);
data.genreStr = cell(N,1);
data.genre = zeros(N,1);
data.N = N;

moods = {'happy','mellow','sad','angry'};
genres = {'rock','pop','house','metal','folk','classical','blues','dubstep','jazz','rap'};

% Read each line.
for i = 1:N
    line = strtrim(fgetl(fid));
    token = strsplit(line);
    data.moodStr{i} = token(1);
    data.mood(i) = find(strcmp(moods,token(1)));
    data.genreStr{i} = token(2);
    data.genre(i) = find(strcmp(genres,token(2)));
end

% Close file.
fclose(fid);