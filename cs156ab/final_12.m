clear; close all;
X = [1 0; 0 1; 0 -1; -1 0; 0 2; 0 -2; -2 0];
y = [-1 -1 -1 1 1 1 1]';
model = svmtrain(y,X,'-q -t 1 -d 2 -r 1 -g 1');
fprintf('Number of support vectors: %d\n',model.totalSV); 