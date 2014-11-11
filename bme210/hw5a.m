% Simulation for no cure case. Does 5 simulations.
function hw5a()
    N = 100;
    a1 = 3; a2 = 9;
    b1 = 10000; b2 = 10001;
    c1 = 0; c2 = 0;
    DT = .45;
    NH = 99; NI = 0; NC = 1; NHI = 0;
    ND = 60; NSIM = 5;
    
    % plotting
    t = 0:ND;
    
    figure;
    hold on;
    title('Spread of Disease among Martians over Time');
    xlabel('Days Elapsed');
    ylabel('Number of Martians');
    
    for (i=1:NSIM)
        data=disease_sim(N,a1,a2,b1,b2,c1,c2,DT,NH,NI,NC,NHI,ND);
        plot(t,data(1,:),'g');      % healthy
        plot(t,data(2,:),'r');      % infected
        plot(t,data(3,:),'b');      % contagious
    end
    legend('Healthy','Infected','Contagious');
    
    % Print Table
    disp('Population of Martians in Each Group over Time');
    disp(sprintf('\tDay\t  NH\tNI\t  NC\tNHI'));
    disp([t;data]');
end