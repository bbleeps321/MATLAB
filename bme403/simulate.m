function simulate()
    clear; close all;

    global P;
    options = odeset('RelTol',1e-5,'AbsTol',1e-5);
    
    % Input
    td = 0:.02:.5;
    Id = [0 5.52 32.41 92.41 100 84.83 60 50.34 31.03 12.41 0 zeros(1,15)];
    P = polyfit(td,Id,9);
    
    % Three element model
    [tmodel3 ymodel3] = ode45(@model3,[0 0.5],80,options);
    Rc = 0.172; Rp = 4.54; Vc = ymodel3;
    V = Vc + I(tmodel3)*Rc;
    plot(tmodel3,V); title('Three Element Model');
    axis([0 .5 0 120]); xlabel('Time (s)'); ylabel('Pressure (mmHg)');
    % Calculate work:
    W3 = trapz(tmodel3, V.*I(tmodel3));
    fprintf('Work in one ejection for 3 param model: %f mmHg*mL\n',W3);
    avgI = trapz(tmodel3, I(tmodel3))/.5;
    avgV = trapz(tmodel3, V)/.5;
    W3c = avgI*avgV*0.5;
    fprintf('Work with same constant flow and pressure: %f mmHg*mL\n',W3c);
    
    % Four element model
    [tmodel4 ymodel4] = ode45(@model4,[0 0.5],[80 0],options);
    Rc = 0.234; Vc = ymodel4(:,1); IL = ymodel4(:,2);
    V = Vc + Rc*(I(tmodel4)-IL);
    figure; plot(tmodel4,V); title('Four Element Model');
    axis([0 .5 0 120]); xlabel('Time (s)'); ylabel('Pressure (mmHg)');
    W4 = trapz(tmodel4, V.*I(tmodel4));
    fprintf('Work in one ejection for 4 param model: %f mmHg*mL\n',W4);
    avgI = trapz(tmodel4, I(tmodel4))/.5;
    avgV = trapz(tmodel4, V)/.5;
    W4c = avgI*avgV*0.5;
    fprintf('Work with same constant flow and pressure: %f mmHg*mL\n',W4c);
end

% For 3 element model
function dVdt = model3(t,Vc)
    Rp = 4.54; C = 0.362;
    dVdt = I(t)/C-Vc/(Rp*C);
end

% For 4 element model
function dydt = model4(t,y)
    Rc = 0.234; Rp = 4.54; C = 0.219; L = 0.019;
    dydt(1,1) = I(t)/C - y(1)/(Rp*C);
    dydt(2,1) = Rc*(I(t)-y(2))/L;
end

% Injection function taken as polynomial fit with I = 0 for t > 0.2.
function y = I(t)
    global P;
    y = polyval(P,t).*(t<0.2);
end