clear; close all;
load hw8_zip_data;
yin = (Xin(:,1)==1) - (Xin(:,1)==5);
yout = (Xout(:,1)==1) - (Xout(:,1)==5);
idxin = find(yin); idxout = find(yout);
N = length(idxin); Nout = length(idxout);

Z = [ones(N,1) Xin(idxin,2) Xin(idxin,3) Xin(idxin,2).*Xin(idxin,3) ...
    Xin(idxin,2).^2 Xin(idxin,3).^2];
Zout = [ones(Nout,1) Xout(idxout,2) Xout(idxout,3) ...
    Xout(idxout,2).*Xout(idxout,3) Xout(idxout,2).^2 Xout(idxout,3).^2];

for (L = [.01 1])
    w = (Z'*Z+L*eye(size(Z,2)))\Z'*yin(idxin);
    
    Ein = sum(yin(idxin) ~= sign(w'*Z')')/N;
    Eout = sum(yout(idxout) ~= sign(w'*Zout')')/Nout;
    fprintf('lambda=%f: Ein=%f, Eout=%f\n',L,Ein,Eout);
end