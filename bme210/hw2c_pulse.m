function hw2c_pulse()
    k = [600 6000 28.8 .288 600 60 .6 .6 36 120];  % Rate constants
    options = odeset('RelTol',1e-5,'AbsTol',1e-5);  % ode45 options
    
    % simulate first pulse
    t0 = [0 2];
    x0 = [12; 12; 12; 0; 0];        % Initial conditions (in uM)
    x0 = x0 + [10; 0; 0; 0; 0];     % add first pulse
    [tpulse0 xpulse0] = ode45(@f, t0, x0, options, k);
    
    % simulate second pulse
    t2 = [2 4];
    x2 = xpulse0(end,:)' + [10 0 0 0 0]';   % Initial conditions (in uM)
    [tpulse2 xpulse2] = ode45(@f, t2, x2, options, k);
    
    % simulate third pulse
    t4 = [4 6];
    x4 = xpulse2(end,:)' + [10 0 0 0 0]';   % Initial conditions (in uM)
    [tpulse4 xpulse4] = ode45(@f, t4, x4, options, k);
    
    % concatenate results
    t = [tpulse0; tpulse2; tpulse4];
    x = [xpulse0; xpulse2; xpulse4];
    
    % Each row corresponds to L, R, D, LR, LD, respectively
    subplot(2,2,1);
    plot(t,x(:,2));
    title('Concentration of R vs Time');
    xlabel('t (min)');
    ylabel('[R] (\muM)');
    axis([-1 6 0 13]);
    
    subplot(2,2,2);
    plot(t,x(:,3));
    title('Concentration of D vs Time');
    xlabel('t (min)');
    ylabel('[D] (\muM)');
    axis([-1 6 0 13]);
    
    subplot(2,2,3);
    plot(t,x(:,4));
    title('Concentration of LR vs Time');
    xlabel('t (min)');
    ylabel('[LR] (\muM)');
    axis([-1 6 0 6]);
    
    subplot(2,2,4);
    plot(t,x(:,5));
    title('Concentration of LD vs Time');
    xlabel('t (min)');
    ylabel('[LD] (\muM)');
    axis([-1 6 0 20]);
end

function dydt = f(t,y,k)
    % dL/dt
    dydt(1) = k(2)*y(4)+k(6)*y(5)-k(1)*y(1)*y(2)-k(5)*y(1)*y(3)+k(9)-k(10)*y(1);
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