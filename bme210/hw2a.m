function hw2a()
    t0 = 0;     % Start and end times in minutes
    tf = 1/60;
    h = 1/60000;  % Step size
    
    % Concentrations stored in matrix x
    % Each row corresponds to a species L, R, D, LR, LD.
    % Each column is the value at a time point/step.
    x = zeros(5,1);
    x(:,1) = [12;12;12;0;0];  % Initial conditions (in uM)
    
    % Rate constants
    k = [600 6000 28.8 .288 600 60 .6 .6];

    t = t0:h:tf;    % time scale
    % Solve with RK2 method
    for (i=1:length(t)-1)
        k1 = h*f(x(:,i),k);
        k2 = h*f(x(:,i)+.5*k1,k);
        x(:,i+1) = x(:,i) + k2; % adding 2 column vectors
    end
    
    disp(x(end,end));
    
    subplot(2,2,1);
    plot(t,x(2,:));
    title('Concentration of R vs Time');
    xlabel('t (min)');
    ylabel('[R] (\muM)');
    
    subplot(2,2,2);
    plot(t,x(3,:));
    title('Concentration of D vs Time');
    xlabel('t (min)');
    ylabel('[D] (\muM)');
    
    subplot(2,2,3);
    plot(t,x(4,:));
    title('Concentration of LR vs Time');
    xlabel('t (min)');
    ylabel('[LR] (\muM)');
    
    subplot(2,2,4);
    plot(t,x(5,:));
    title('Concentration of LD vs Time');
    xlabel('t (min)');
    ylabel('[LD] (\muM)');
end

function dydt = f(x,k)
    % dL/dt
    dydt(1) = k(2)*x(4)+k(6)*x(5)-k(1)*x(1)*x(2)-k(5)*x(1)*x(3);
    % dR/dt
    dydt(2) = k(2)*x(4)+k(8)*x(1)*x(3)-(k(1)+k(7))*x(1)*x(2);
    % dD/dt
    dydt(3) = k(6)*x(5)+k(7)*x(1)*x(2)-(k(5)+k(8))*x(1)*x(3);
    % dLR/dt
    dydt(4) = k(1)*x(1)*x(2)+k(4)*x(5)-(k(2)+k(3))*x(4);
    % dLD/dt
    dydt(5) = k(3)*x(4)+k(5)*x(1)*x(3)-(k(4)+k(6))*x(5);
    dydt = dydt';       % so it's a column vector
end