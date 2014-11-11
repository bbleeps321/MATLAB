clear; close all;
load hw6_in_out_data;
Zin = [ones(size(xin,1),1) xin(:,1) xin(:,2) xin(:,1).^2 xin(:,2).^2 ...
    xin(:,1).*xin(:,2) abs(xin(:,1)-xin(:,2)) abs(xin(:,1)+xin(:,2))];
Zout = [ones(size(xout,1),1) xout(:,1) xout(:,2) xout(:,1).^2 xout(:,2).^2 ...
    xout(:,1).*xout(:,2) abs(xout(:,1)-xout(:,2)) abs(xout(:,1)+xout(:,2))];

w = ((Zin'*Zin)\Zin')*yin;
Ein = sum(sign(w'*Zin')~=yin')/size(Zin,1)
Eout = sum(sign(w'*Zout')~=yout')/size(Zout,1)