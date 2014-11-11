function lin_interp()
    Ts = 1;
    n = 0:10;
    t = -Ts:Ts/10:(10+1)*Ts;
    xn = (0.9.^n).*(n>=0);
    xt = zeros(1,length(t));
    %figure;
    %hold on;
    for i=1:length(n)
        delay = Ts*n(i).*ones(1,length(t));
    %     interp = xn(i)*p(t-delay,Ts);
    %     plot(t,interp,'r');
        xt = xt + xn(i)*p(t-delay,Ts);
    end
    plot(t,xt,'b-');
    axis([min(n)*Ts max(n)*Ts 0 1]);
end

function interp = p(t,T)
    interp = (1-abs(t)/T).*(abs(t)<T);
end