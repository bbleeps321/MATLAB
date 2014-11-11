function hw2_3
    options = odeset('RelTol',1e-5,'AbsTol',1e-5);
    va = [1.5 1.5 3];
    q = [3 1.5 1.5];
    for (i=1:3)
        [t y] = ode45(@vqcalc,[0 15],[.14 .05],options,va(i),q(i));
        subplot(3,1,i);
        plot(t,y(:,1),'b');
        hold on;
        plot(t,y(:,2),'r');
        legend('F_A_O_2','F_A_C_O_2');
        axis([0 15 0 .2]);
        title(sprintf('V:Q = %f:%f',va(i),q(i)));
        xlabel('Time (min)');
        ylabel('Fraction');
        
        fprintf('Run %d: %f:%f\n',i,va(i),q(i));
        fprintf('FAO2 = %f\n',y(end,1));
        fprintf('FACO2 = %f\n\n',y(end,2));        
    end
end

function yp = vqcalc(t,y,va,q)
% va = 1.5;
% q = 3;
cvo2 = 15;
cvco2 = 53;
b = 760;
k = 8.63/(b-47);
pao2 = y(1)*(b-47);
cao2 = 20.1*((1-exp(-.046*pao2))^2);
paco2 = y(2)*(b-47);
caco2 = 48+6*(paco2-40)/7;
yp(1) = (.21*va+q*k*(cvo2-cao2)-y(1)*va)/5.;
yp(2) = (q*k*(cvco2-caco2)-y(2)*va)/5.;
yp=yp';
end