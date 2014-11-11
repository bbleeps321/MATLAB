clear; close all;
load hw8_zip_data;

Nin = size(Xin,1); Nout = size(Xout,1);
C = .01; Q = 2;
for (n = 7)%0:9)
    yin = 2*(Xin(:,1) == n)-1;
    yout = 2*(Xout(:,1) == n)-1;
    % Train
    K = (1+Xin*Xin').^Q;
    Q = (yin*yin').*Q;
    thresh = 7e-3;
    cvx_quiet true;
    cvx_begin
        variable a(Nin)
        minimize(.5*a'*Q*a - ones(1,Nin)*a)
        subject to
            yin'*a == 0
            0 <= a
            a <= C
    cvx_end;
%     a = a.*(a >= thresh);
    wsvm = sum(([a.*yin a.*yin a.*yin].*Xin))'; % 3x1 vect
    idx = find(a > thresh,1);
    b = 1/yin(idx) - wsvm'*Xin(idx,:)';    
    
    Ein = sum(yin' ~= sign(wsvm'*Xin'+b))/Nin;
    Eout = sum(yout' ~= sign(wsvm'*Xout'+b))/Nout;
    Nsvm = sum(a > thresh);
    % Print n, Ein, Eout, numSV
    fprintf('n=%d,Ein=%f, Eout=%f, numSV=%d\n',n,Ein,Eout,Nsvm);
end