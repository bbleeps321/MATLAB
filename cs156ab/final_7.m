clear; close all;
load hw8_zip_data;
N = size(Xin,1);
Z = [ones(N,1) Xin(:,2:3)];
for (n = 5:9)
    yin = 2*(Xin(:,1) == n) - 1;
    
    w = (Z'*Z+eye(size(Z,2)))\Z'*yin;
    
    Ein = sum(yin ~= sign(w'*Z')')/N;
    fprintf('%d vs all: Ein=%f\n',n,Ein);
end