% Create partitions of data for N-fold CV (in the columns).
% First row of each cell is the training data. Second row is the test.
function [Xpart,ypart] = getPartitions(X,y,N)

incr = floor(length(y)/N);

Xpart = cell(2,N);
ypart = cell(2,N);
for i = 1:N
    startidx = (i-1)*incr + 1;
    endidx = i*incr;
    tempX = X; tempX(startidx:endidx,:) = [];
    tempy = y; tempy(startidx:endidx) = [];
    Xpart{1,i} = tempX;
    ypart{1,i} = tempy;
    Xpart{2,i} = X(startidx:endidx,:);
    ypart{2,i} = y(startidx:endidx);
end
