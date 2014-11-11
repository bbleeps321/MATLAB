clear; close all;
load hw8_zip_data;
C = .01; Q = 2;
for (n = 0:9)
    yin = 2*(Xin(:,1)==n)-1;
    yout =2*(Xout(:,1)==n)-1;

    model = svmtrain(yin,Xin(:,2:3),...
        sprintf('-t 1 -c %f -d %d -r 1 -g 1 -h 0 -q',C,Q));  
    nSV = model.totalSV;
    
    [predictLabel,acc,probVal] = svmpredict(yin,Xin(:,2:3), model,'-q');
    Ein = 1-acc(1)/100;
    
    [predictLabel,acc,probVal] = svmpredict(yout,Xout(:,2:3), model,'-q');
    Eout = 1-acc(1)/100;
    
    % Print n, Ein, Eout, numSV
    fprintf('%d vs all: Ein=%f, Eout=%f, numSV=%d\n',n,Ein,Eout,nSV);
end