%% Load data.
load data;
NumUsers = length(unique(userData.userID)); % m
NumMovies = length(movieData.movieID); % n
NumRatings = length(userData.rating);

%% Test

% Y = [5,3,0,1; 4,0,0,1; 1,1,0,5; 1,0,0,4; 0,1,5,4];
% 
% U = [0.26342575  0.96226192; 0.74782785  0.3067186; 0.03298189  0.74346395; 0.04801735  0.62895194; 0.98342322  0.71977245];
% V = [0.90622035  0.16534153; 0.10691805  0.29883061; 0.54543389  0.40227939; 0.50983715  0.55063456];
% [U,V] = matrixFactorization(Y,U,V,2)

% answer:
% [[ 2.30932208  0.47854975]
%  [ 1.76240504  0.46475043]
%  [ 0.16183393  2.08392299]
%  [ 0.14509524  1.66952265]
%  [ 1.08978803  1.71041196]]

%%  Set up Y matrix.
Y = zeros(NumUsers,NumMovies);
for i = 1:NumRatings
    Y(userData.userID(i),userData.movieID(i)) = userData.rating(i);
end


%% Matrix Factorization (stochastic gradient descent)
K = 20;
stepsize = .01;
lambda = .05;

U = rand(NumUsers,K); % Set up U,V randomly.
V = rand(NumMovies,K);
[U,V,obj] = matrixFactorization(Y,U,V,K,500,stepsize,lambda);
save('results','K','U','V','err','steps','stepsize','lambda');

figure;
plot(obj);


%% Take SVD of factorized matrices.
[A,S,B] = svd(V');
% Aproj = zeros(size(A));
% Aproj(:,1:2) = A(:,1:2);
Aproj = A(:,1:2);
% [size(Aproj); size(V); size(U)]

Vproj = V*Aproj;
Uproj = U*Aproj;

%% Project and plot movies onto space.
fprintf('~~~~\n');
% idx = [1 2 12 50 67 94 95 96 173 174 183 195 270 364];
genres = {'Comedy','Sci-fi','Sci-fi Horror', 'Slasher/Horror','Romance'};
genreIdx = {[67 780],[96 195 270],[183 176],[439 852 1601],[1502 1374]};
% idx = genreIdx{3};
% scatter(Vproj(idx,1),Vproj(idx,2));

figure(10); clf;
% col = 'rgmb';
for i = 1:length(genres);%[1 2 4 5]
    idx = genreIdx{i};
    scatter(Vproj(idx,1),Vproj(idx,2)); hold on;
    
    fprintf('Genre: %s\n',genres{i});
    for j = idx
        % Label the point on the graph.
        text(Vproj(j,1)+.1,Vproj(j,2),movieData.titles{j});
        
        fprintf('\t(%d) %s: %f,%f\n',j,movieData.titles{j},Vproj(j,1),Vproj(j,2));
    end
end
axis([-2.5 1 -.5 .9]);
set(gca,'XTickLabel','');
set(gca,'YTickLabel','');
xlabel('Component 1');
ylabel('Component 2');

title('Movies and users projected to principal dimensions');

%% User id stuff
% 44: liked terminator and ace ventura, didn't like dances with wolves
% 913: like alien, didn't like chasing aliens
userIDs = [44 913];
for userID = userIDs
    idx = find(userData.userID==userID)';
    fprintf('~~~\n');
    for i = idx
        movieId = userData.movieID(i);
        movieTitle = movieData.titles{movieId};
        rating = userData.rating(i);
        fprintf('(%d) %s: %d\n',movieId,movieTitle,rating);
    end
    % Project.
    scatter(Uproj(userID,1),Uproj(userID,2),72*6,'p');
    text(Uproj(userID,1)+.1,Uproj(userID,2),sprintf('User %d',userID));
end


%% Searching for movies.
fprintf('~~~\n');
idx = find(Vproj(:,1)<-1 & Vproj(:,2) < -.2);
if isempty(idx)
    warning('none found');
end
for i = idx'
    fprintf('(%d) %s\n',i,movieData.titles{i});
end

%% Searching for users.
fprintf('~~~\n');
idx = find(Uproj(:,1)<-1 & Uproj(:,2) > 0);
if isempty(idx)
    warning('none found');
end
for i = idx'
    fprintf('(%d) %f,%f\n',i,Uproj(i,1), Uproj(i,2)); %s\n',i,movieData.titles{i});
end
% movieID = 183;
% idx = find(userData.movieID==movieID)';
% for i = idx
%     if userData.rating(i) > 3
%         uid =userData.userID(i);
%         fprintf('(%d) %d: %f,%f\n',uid, userData.rating(i),Uproj(uid,1),Uproj(uid,2));
%     end
% end

%% Search for all ratings by a certain user.
userID = 44;
idx = find(userData.userID == userID)';
for i = idx
    movieId = userData.movieID(i);
%     if Vproj(movieId,1) < -1.5
%         continue;
%     end
    movieTitle = movieData.titles{movieId};
    rating = userData.rating(i);
    if rating <3
        
    fprintf('(%d) %s: %d; %f,%f\n',movieId,movieTitle,rating,Vproj(movieId,1),Vproj(movieId,2));
    end
end