clear; close all;
load hw8_zip_data;
N = size(Xin,1); Nout = size(Xout,1);
Z = [ones(N,1) Xin(:,2) Xin(:,3) Xin(:,2).*Xin(:,3) ...
    Xin(:,2).^2 Xin(:,3).^2];
for (n = 0:4)
    yin = 2*(Xin(:,1) == n) - 1;
    yout = 2*(Xout(:,1) == n) - 1;
    Zout = [ones(Nout,1) Xout(:,2) Xout(:,3) ...
            Xout(:,2).*Xout(:,3) Xout(:,2).^2 Xout(:,3).^2];
    
    w = (Z'*Z+eye(size(Z,2)))\Z'*yin;
    
    Eout = sum(yout ~= sign(w'*Zout')')/Nout;
    fprintf('%d vs all: Eout=%f\n',n,Eout);
end