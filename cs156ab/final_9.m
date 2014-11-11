clear; close all;
load hw8_zip_data;
N = size(Xin,1); Nout = size(Xout,1);
Z1 = [ones(N,1) Xin(:,2:3)];
Z2 = [ones(N,1) Xin(:,2) Xin(:,3) Xin(:,2).*Xin(:,3) ...
    Xin(:,2).^2 Xin(:,3).^2];
for (n = 0:9)
    yin = 2*(Xin(:,1) == n) - 1;
    yout = 2*(Xout(:,1) == n) - 1;
    Z1out = [ones(Nout,1) Xout(:,2:3)];
    Z2out = [ones(Nout,1) Xout(:,2) Xout(:,3) ...
        Xout(:,2).*Xout(:,3) Xout(:,2).^2 Xout(:,3).^2];
    
    w1 = (Z1'*Z1+eye(size(Z1,2)))\Z1'*yin;
    w2 = (Z2'*Z2+eye(size(Z2,2)))\Z2'*yin;
    
    Ein1 = sum(yin ~= sign(w1'*Z1')')/N;
    Ein2 = sum(yin ~= sign(w2'*Z2')')/N;
    Eout1 = sum(yout ~= sign(w1'*Z1out')')/Nout;
    Eout2 = sum(yout ~= sign(w2'*Z2out')')/Nout;
    fprintf('%d vs all:\n\tUntransformed Ein=%f, Eout=%f\n\tTransformed Ein=%f, Eout=%f\n',...
        n,Ein1,Eout1,Ein2,Eout2);
end