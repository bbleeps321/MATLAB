clear; close all;
load hw6_in_out_data;
Zin = [ones(size(xin,1),1) xin(:,1) xin(:,2) xin(:,1).^2 xin(:,2).^2 ...
    xin(:,1).*xin(:,2) abs(xin(:,1)-xin(:,2)) abs(xin(:,1)+xin(:,2))];
Zout = [ones(size(xout,1),1) xout(:,1) xout(:,2) xout(:,1).^2 xout(:,2).^2 ...
    xout(:,1).*xout(:,2) abs(xout(:,1)-xout(:,2)) abs(xout(:,1)+xout(:,2))];

fprintf('25 training, 10 validation\n');
for (k=3:7+1)
    ZinTrain = Zin(1:25,1:k);
    yinTrain = yin(1:25);
    w = ((ZinTrain'*ZinTrain)\ZinTrain')*yinTrain;
    Eval = sum(sign(w'*Zin(26:end,1:k)')~=yin(26:end)')/10;
    Eout = sum(sign(w'*Zout(:,1:k)')~=yout')/size(Zout(:,1:k),1);
    fprintf('k=%d, Eval=%f, Eout=%f\n',k-1,Eval,Eout);
end

fprintf('10 training, 25 validation\n');
for (k=3:7+1)
    ZinTrain = Zin(26:end,1:k);
    yinTrain = yin(26:end);
    w = ((ZinTrain'*ZinTrain)\ZinTrain')*yinTrain;
    Eval = sum(sign(w'*Zin(1:25,1:k)')~=yin(1:25)')/25;
    Eout = sum(sign(w'*Zout(:,1:k)')~=yout')/size(Zout(:,1:k),1);
    fprintf('k=%d, Eval=%f, Eout=%f\n',k-1,Eval,Eout);
end