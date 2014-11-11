clear; close all;
load hw8_zip_data;

yin = (Xin(:,1)==1) - (Xin(:,1)==5);
idxin = find(yin);
yout = (Xout(:,1)==1) - (Xout(:,1)==5);
idxout = find(yout);

for (C = [.01 1 100 10^4 10^6])
    % Train
    model = svmtrain(yin(idxin),Xin(idxin,2:3),...
        sprintf('-t 2 -c %f -g 1 -h 0 -q',C));  
    nSV = model.totalSV;

    [predictLabel,acc,probVal] = ...
        svmpredict(yin(idxin),Xin(idxin,2:3), model,'-q');
    Ein = 1-acc(1)/100;

    [predictLabel,acc,probVal] = ...
        svmpredict(yout(idxout),Xout(idxout,2:3), model,'-q');
    Eout = 1-acc(1)/100;

    % Print n, Ein, Eout, numSV
    fprintf('C=%f: Ein=%f, Eout=%f, numSV=%d\n',C,Ein,Eout,nSV);
end