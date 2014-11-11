clear; close all;
load hw8_zip_data;

yin = (Xin(:,1)==1) - (Xin(:,1)==5);
idxin = find(yin);
N = length(idxin);
Q = 2; C = 10.^[-4:0];
counts = zeros(1,5);
for (i = 1:100)
    bestEcv = 100000;
    randidx = idxin(randperm(N));
    for (c = C)
        acc = svmtrain(yin(randidx),Xin(randidx,2:3),...
            sprintf('-t 1 -q -v 10 -c %f -d %d -r 1 -g 1 -h 0 -q',c,Q));
        Ecv = 1-acc/100;
        if (Ecv < bestEcv)
            bestEcv = Ecv;
            bestC = c;
        end
    end
    idx = find(C==bestC);
    counts(idx) = counts(idx)+1;
end
[m i] = max(counts);
c = C(i);
avgEcv = 0;
for (i = 1:100)
    randidx = idxin(randperm(N));
    acc = svmtrain(yin(randidx),Xin(randidx,2:3),...
            sprintf('-t 1 -q -v 10 -c %f -d %d -r 1 -g 1 -h 0 -q',c,Q));
    Ecv = 1-acc/100;
    avgEcv = avgEcv+Ecv;
end
[C' counts']
avgEcv = avgEcv/100