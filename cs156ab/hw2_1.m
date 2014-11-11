K = 100000;
v1 = zeros(1,K);
vrand = zeros(1,K);
vmin = zeros(1,K);
for (k = 1:K)
    % Flip 1000 coins 10 times each and store the percentage of heads.
    flips = (rand(10,1000) < .5);
    % Average along each column is frequency of heads.
    data = mean(flips);
    v1(k) = data(1);
    vrand(k) = data(randi(length(data),1));
    vmin(k) = min(data);
end
mean(v1) % .5012
mean(vrand) % .5000
mean(vmin) % .0374