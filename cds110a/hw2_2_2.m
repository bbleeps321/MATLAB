function hw2_2_2
    y1 = linspace(0,50,10);
    y2 = linspace(10,30,10);
    figure; hold on;
    for i = (1:10)
        for (j=1:10)
            [t,x] = ode45(@cruise,[0 10],[y1(i); y2(j)]);
            plot(x(:,1),x(:,2));
        end
    end
    title('Cruise Control V');
    xlabel('position'); ylabel('velocity');
    figure; plot(t,x);
    
end

% y(1)=x,y(2)=v
function dy = cruise(t,y)
    m=1000; alpha=16; g=9.8;
    rho=1.3; Cd=.32; A=2.4; Tm=190; wm=420; beta=.4; Cr=0.01;
    T = @(v) Tm*(1-beta*(alpha*v/wm-1)^2);
    dy = zeros(2,1);
    dy(1) = y(2);
    dy(2) = alpha*u(y(2),t)*T(y(2))/m - g*Cr*sign(y(2)) - rho*Cd*A*y(2)^2/2/m;
end

function y = u(v,t)
    kp=.5; ki=.1; vref=20;
    y = kp*(vref-v)+ki*(vref-v)*t;
    y = max(y,0);
    y = min(y,1);
end