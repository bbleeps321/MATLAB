function hw2b()
    k = [600 6000 28.8 .288 600 60 .6 .6];  % Rate constants

    t0 = 0;     % Start and end times in minutes
    tf = 1/60;
    % each row corresponds to L, R, D, LR, LD, respectively
    x0 = [12; 12; 12; 0; 0];    % Initial conditions (in uM)
    
    % Call ode45
    options = odeset('RelTol',1e-5,'AbsTol',1e-5);
    [t x] = ode45(@f, [t0 tf], x0, options, k);
    
    subplot(2,2,1);
    plot(t,x(:,2));
    title('Concentration of R vs Time');
    xlabel('t (min)');
    ylabel('[R] (\muM)');
    
    subplot(2,2,2);
    plot(t,x(:,3));
    title('Concentration of D vs Time');
    xlabel('t (min)');
    ylabel('[D] (\muM)');
    
    subplot(2,2,3);
    plot(t,x(:,4));
    title('Concentration of LR vs Time');
    xlabel('t (min)');
    ylabel('[LR] (\muM)');
    
    subplot(2,2,4);
    plot(t,x(:,5));
    title('Concentration of LD vs Time');
    xlabel('t (min)');
    ylabel('[LD] (\muM)');
end

function dydt = f(t,y,k)
    % dL/dt
    dydt(1) = k(2)*y(4)+k(6)*y(5)-k(1)*y(1)*y(2)-k(5)*y(1)*y(3);
    % dR/dt
    dydt(2) = k(2)*y(4)+k(8)*y(1)*y(3)-(k(1)+k(7))*y(1)*y(2);
    % dD/dt
    dydt(3) = k(6)*y(5)+k(7)*y(1)*y(2)-(k(5)+k(8))*y(1)*y(3);
    % dLR/dt
    dydt(4) = k(1)*y(1)*y(2)+k(4)*y(5)-(k(2)+k(3))*y(4);
    % dLD/dt
    dydt(5) = k(3)*y(4)+k(5)*y(1)*y(3)-(k(4)+k(6))*y(5);
    dydt = dydt';
end