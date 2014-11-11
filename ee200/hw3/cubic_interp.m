function cubic_interp()
    Ts = 1;
    n = 0:10;
    t = -2*Ts:Ts/10:(10+2)*Ts;
    xn = (0.9.^n).*(n>=0);
    xt = zeros(1,length(t));
%     figure;
%     hold on;
%     c=['r' 'g' 'c' 'y' 'k'];
    for i=1:length(n)
        delay = Ts*n(i).*ones(1,length(t));
%         if ((i>=3) && (i<=7))
%             interp = xn(i)*p(t-delay,Ts);
%             plot(t,interp,c(i-2));
%         end
        xt = xt + xn(i)*p(t-delay,Ts);
    end
    plot(t,xt,'b');
    axis([min(n)*Ts max(n)*Ts 0 1]);
end

function interp = p(t,T)
    interp = (3*(abs(t).^3)/(4*T^3) - (7.*t.^2)/(4*T^2) + 1).*(abs(t)<(2*T));
end