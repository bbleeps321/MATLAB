function hw2_2
    m=1000; vref=20; alpha=16; g=9.8;
    rho=1.3; Cd=.32; A=2.4; Tm=190; wm=420; beta=.4; Cr=0.01;
    T = @(v) Tm*(1-beta*(alpha*v/wm-1)^2);
    f = @(t,Y)...
        [alpha*u(Y(1),Y(2))*T(Y(1))/m - g*Cr*sign(Y(1)) - rho*Cd*A*Y(1)^2/2/m; ...
        vref - Y(1)];
    y1 = linspace(0,30,30);
    y2 = linspace(-15,15,30);
    [x,y] = meshgrid(y1,y2);
    uu = zeros(size(x));
    vv = zeros(size(x));
    t=0;
    for i = 1:numel(x)
        Yprime = f(t,[x(i); y(i)]);
        uu(i) = Yprime(1);
        vv(i) = Yprime(2);
    end
    quiver(x,y,uu,vv,2,'k'); hold on;
    streamline(x,y,uu,vv,15,0);
    title('Cruise Control V');
    xlabel('v'); ylabel('z');
    axis tight equal;
end

function y = u(v,z)
    kp=.5; ki=.1; vref=20;
    y = kp*(vref-v)+ki*z;
    if (y < 0) y = 0;
    elseif (y > 1) y = 1;
    end
end