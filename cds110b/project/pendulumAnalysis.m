function pendulumAnalysis(sim)
    close all;

    figI = 1;

    col = 'rgbcmyk';
    ceff = zeros(5,1);
    L = [1 .75 .5 .25 .1]';
    D = [0 25 75 125 175]';
    N = [.01 .03 .05 .1 .3]';
    ti = 1:(10/.025+1); % First 10 seconds.
    M = 1; m = .1;

    if (sim(1))
        % LQR: length vs control effort
        % pendulumSim(1,1,1,[.1;.1;.1;.1],.01,0,'lqr1')
        % pendulumSim(1,.75,1,[.1;.1;.1;.1],.01,0,'lqr2')
        % pendulumSim(1,.5,1,[.1;.1;.1;.1],.01,0,'lqr3')
        % pendulumSim(1,.25,1,[.1;.1;.1;.1],.01,0,'lqr4')
        % pendulumSim(1,.1,1,[.1;.1;.1;.1],.01,0,'lqr5')
        for (i = 1:5)
            load(sprintf('lqr%d',i));
            figure(figI);
            subplot(2,1,1); plot(t,x(1,:),col(i)); hold on;
            subplot(2,1,2); plot(t,x(2,:),col(i)); hold on;

            figure(figI+1);
            plot(t,u,col(i)); hold on;
            ceff(i) = sqrt(mean(u.^2));
        end
        figure(figI); legend('l=1','l=.75','l=.5','l=.25','l=.1');
        subplot(2,1,1); xlabel('Time (s)'); ylabel('Position');
        title('Inverted pendulum trajectories for different lengths (LQR Control)');
        subplot(2,1,2); xlabel('Time (s)'); ylabel('Angle (rad)');
        figure(figI+1); legend('l=1','l=.75','l=.5','l=.25','l=.1');
        xlabel('Time (s)'); ylabel('Control effort');
        title('Control effort for different lengths (LQR Control)');
        figure(figI+2); plot(L,ceff);
        title('Average control effort for different lengths (LQR Control)');
        xlabel('Pendulum length (m)'); ylabel('Average control effort');
        disp('LQR length vs control effort:');
        disp([L ceff]);
    end

    if (sim(2))
        % LQG: length vs control effort
        % pendulumSim(2,1,1,[.1;.1;.1;.1],.01,0,'lqg1')
        % pendulumSim(2,.75,1,[.1;.1;.1;.1],.01,0,'lqg2')
        % pendulumSim(2,.5,1,[.1;.1;.1;.1],.01,0,'lqg3')
        % pendulumSim(2,.25,1,[.1;.1;.1;.1],.01,0,'lqg4')
        % pendulumSim(2,.1,1,[.1;.1;.1;.1],.01,0,'lqg5')
        figI = figI + 3;
        for (i = 1:5)
            load(sprintf('lqg%d',i));
            figure(figI);
            subplot(2,1,1); plot(t,x(1,:),col(i)); hold on;
            subplot(2,1,2); plot(t,x(2,:),col(i)); hold on;

            figure(figI+1);
            plot(t,u,col(i)); hold on;
            ceff(i) = sqrt(mean(u.^2));
        end
        figure(figI); legend('l=1','l=.75','l=.5','l=.25','l=.1');
        subplot(2,1,1); xlabel('Time (s)'); ylabel('Position');
        title('Inverted pendulum trajectories for different lengths (LQG Control)');
        subplot(2,1,2); xlabel('Time (s)'); ylabel('Angle (rad)');
        figure(figI+1); legend('l=1','l=.75','l=.5','l=.25','l=.1');
        xlabel('Time (s)'); ylabel('Control effort');
        title('Control effort for different lengths (LQG Control)');
        figure(figI+2); plot(L,ceff);
        title('Average control effort for different lengths (LQG Control)');
        xlabel('Pendulum length (m)'); ylabel('Average control effort');
        disp('LQG length vs control effort:');
        disp([L ceff]);
    end

    if (sim(3))
        % LQG: obs length vs control effort
        % pendulumSim(2,1,1,[.1;.1;.1;.1],.01,0,'lqgO1')
        % pendulumSim(2,1,.75,[.1;.1;.1;.1],.01,0,'lqgO2')
        % pendulumSim(2,1,.5,[.1;.1;.1;.1],.01,0,'lqgO3')
        % pendulumSim(2,1,.25,[.1;.1;.1;.1],.01,0,'lqgO4')
        % pendulumSim(2,1,.1,[.1;.1;.1;.1],.01,0,'lqgO5')
        figI = figI + 3;
        for (i = 1:5)
            load(sprintf('lqgO%d',i));
            figure(figI);
            subplot(2,1,1); plot(t,x(1,:),col(i)); hold on;
            subplot(2,1,2); plot(t,x(2,:),col(i)); hold on;

            figure(figI+1);
            plot(t,u,col(i)); hold on;
            ceff(i) = sqrt(mean(u.^2));
        end
        figure(figI); legend('l0=1','l0=.75','l0=.5','l0=.25','l0=.1');
        subplot(2,1,1); xlabel('Time (s)'); ylabel('Position');
        title('Inverted pendulum trajectories for different observation lengths (LQG Control)');
        subplot(2,1,2); xlabel('Time (s)'); ylabel('Angle (rad)');
        figure(figI+1); legend('l0=1','l0=.75','l0=.5','l0=.25','l0=.1');
        xlabel('Time (s)'); ylabel('Control effort');
        title('Control effort for different observation lengths (LQG Control)');
        figure(figI+2); plot(L,ceff);
        title('Average control effort for different lengths (LQG Control)');
        xlabel('Pendulum length (m)'); ylabel('Average control effort');
        disp('LQG observation length vs control effort:');
        disp([L ceff]);
    end

    if (sim(4))
        % LQR: delay
        % pendulumSim(1,1,1,[.1;.1;.1;.1],.01,0,'lqrd1')
        % pendulumSim(1,1,1,[.1;.1;.1;.1],.01,.025,'lqrd2')
        % pendulumSim(1,1,1,[.1;.1;.1;.1],.01,.075,'lqrd3')
        % pendulumSim(1,1,1,[.1;.1;.1;.1],.01,.125,'lqrd4')
        % pendulumSim(1,1,1,[.1;.1;.1;.1],.01,.175,'lqrd5')
        figI = figI + 3;
        for (i = 1:5)
            load(sprintf('lqrd%d',i));
            figure(figI);
            subplot(2,1,1); plot(t,x(1,:),col(i)); hold on;
            subplot(2,1,2); plot(t,x(2,:),col(i)); hold on;

            figure(figI+1);
            plot(t,u,col(i)); hold on;
            ceff(i) = sqrt(mean(u.^2));
        end
        figure(figI); legend('delay=0ms','delay=25ms','delay=75ms','delay=125ms','delay=175ms');
        subplot(2,1,1); xlabel('Time (s)'); ylabel('Position');
        title('Inverted pendulum trajectories for different delays (LQR Control)');
        subplot(2,1,2); xlabel('Time (s)'); ylabel('Angle (rad)');
        figure(figI+1); legend('delay=0ms','delay=25ms','delay=75ms','delay=125ms','delay=175ms');
        xlabel('Time (s)'); ylabel('Control effort');
        title('Control effort for different delays (LQR Control)');
        figure(figI+2); plot(D,ceff);
        title('Average control effort for different delays (LQR Control)');
        xlabel('Delay (ms)'); ylabel('Average control effort');
        disp('LQR delay (ms) vs control effort:');
        disp([D ceff]);
    end

    if (sim(5))
        % LQG: delay
        % pendulumSim(2,1,1,[.1;.1;.1;.1],.01,0,'lqgd1')
        % pendulumSim(2,1,1,[.1;.1;.1;.1],.01,.025,'lqgd2')
        % pendulumSim(2,1,1,[.1;.1;.1;.1],.01,.075,'lqgd3')
        % pendulumSim(2,1,1,[.1;.1;.1;.1],.01,.125,'lqgd4')
        figI = figI + 3;
        for (i = 1:5)
            load(sprintf('lqgd%d',i));
            figure(figI);
            subplot(2,1,1); plot(t,x(1,:),col(i)); hold on;
            subplot(2,1,2); plot(t,x(2,:),col(i)); hold on;

            figure(figI+1);
            plot(t,u,col(i)); hold on;
            ceff(i) = sqrt(mean(u.^2));
        end
        figure(figI); legend('delay=0ms','delay=25ms','delay=75ms','delay=125ms','delay=175ms');
        subplot(2,1,1); xlabel('Time (s)'); ylabel('Position');
        title('Inverted pendulum trajectories for different delays (LQG Control)');
        subplot(2,1,2); xlabel('Time (s)'); ylabel('Angle (rad)');
        figure(figI+1); legend('delay=0ms','delay=25ms','delay=75ms','delay=125ms','delay=175ms');
        xlabel('Time (s)'); ylabel('Control effort');
        title('Control effort for different delays (LQG Control)');
        figure(figI+2); plot(D,ceff);
        title('Average control effort for different delays (LQG Control)');
        xlabel('Delay (ms)'); ylabel('Average control effort');
        disp('LQG delay (ms) vs control effort:');
        disp([D ceff]);
    end

    if (sim(6))
        % LQR vs LQG vs human control trajectories
        figI = figI + 3;
        h1x = zeros(4,length(ti));
        h1u = zeros(1,length(ti));
        for (i = 1:5)
            load(sprintf('hum1%d',i'));
            h1x = h1x+x(:,ti);
            h1u = h1u+u(ti);
        end
        h1x = h1x/5; h1u = h1u/5/(M+m);
        ceff(1) = sqrt(mean(h1u.^2));
        figure(figI);
        subplot(2,1,1); plot(t(ti),h1x(1,:),'r'); hold on;
        subplot(2,1,2); plot(t(ti),h1x(2,:),'r'); hold on;
        figure(figI+1); plot(t(ti),h1u,'r'); hold on;
        load('lqr1');
        figure(figI); subplot(2,1,1); plot(t,x(1,:),'g');
        subplot(2,1,2); plot(t,x(2,:),'g');
        figure(figI+1); plot(t,u,'g');
        ceff(2) = sqrt(mean(u.^2));
        load('lqg1');
        figure(figI); subplot(2,1,1); plot(t,x(1,:),'b');
        subplot(2,1,2); plot(t,x(2,:),'b');
        figure(figI+1); plot(t,u,'b');
        ceff(3) = sqrt(mean(u.^2));



        figure(figI); legend('Human','LQR','LQG');
        subplot(2,1,1); xlabel('Time (s)'); ylabel('Position');
        title('Inverted pendulum trajectories for different control methods');
        subplot(2,1,2); xlabel('Time (s)'); ylabel('Angle (rad)');
        figure(figI+1); legend('Human','LQR','LQG');
        xlabel('Time (s)'); ylabel('Control effort');
        title('Control effort for different control methods');
        fprintf('Control method vs control effort:\n');
        fprintf('\tHuman\t%f\n',ceff(1));
        fprintf('\tLQR\t%f\n',ceff(2));
        fprintf('\tLQG\t%f\n',ceff(3));    
    end

    % LQR: noise vs control effort

    % LQG: noise vs control effort

    if (sim(7))
        % LQR: noise vs control effort
        % pendulumSim(1,1,1,[.1;.1;.1;.1],.01,0,'lqrn1')
        % pendulumSim(1,1,1,[.1;.1;.1;.1],.03,0,'lqrn2')
        % pendulumSim(1,1,1,[.1;.1;.1;.1],.05,0,'lqrn3')
        % pendulumSim(1,1,1,[.1;.1;.1;.1],.1,0,'lqrn4')
        % pendulumSim(1,1,1,[.1;.1;.1;.1],.3,0,'lqrn5')
        figI = figI + 3;
        for (i = 1:5)
            load(sprintf('lqrn%d',i));
            figure(figI);
            subplot(2,1,1); plot(t,x(1,:),col(i)); hold on;
            subplot(2,1,2); plot(t,x(2,:),col(i)); hold on;

            figure(figI+1);
            plot(t,u,col(i)); hold on;
            ceff(i) = sqrt(mean(u.^2));
        end
        figure(figI); legend('\sigma^2=.01','\sigma^2=.03','\sigma^2=.05','\sigma^2=.1','\sigma^2=.3');
        subplot(2,1,1); xlabel('Time (s)'); ylabel('Position');
        title('Inverted pendulum trajectories for different noise levels (LQR Control)');
        subplot(2,1,2); xlabel('Time (s)'); ylabel('Angle (rad)');
        figure(figI+1); legend('\sigma^2=.01','\sigma^2=.03','\sigma^2=.05','\sigma^2=.1','\sigma^2=.3');
        xlabel('Time (s)'); ylabel('Control effort');
        title('Control effort for different noise levels (LQR Control)');
        figure(figI+2); plot(N,ceff);
        title('Average control effort for different noise levels (LQR Control)');
        xlabel('Noise'); ylabel('Average control effort');
        disp('LQR noise vs control effort:');
        disp([N ceff]);
    end

    if (sim(8))
        % LQG: noise vs control effort
        % pendulumSim(2,1,1,[.1;.1;.1;.1],.01,0,'lqgn1')
        % pendulumSim(2,1,1,[.1;.1;.1;.1],.03,0,'lqgn2')
        % pendulumSim(2,1,1,[.1;.1;.1;.1],.05,0,'lqgn3')
        % pendulumSim(2,1,1,[.1;.1;.1;.1],.1,0,'lqgn4')
        % pendulumSim(2,1,1,[.1;.1;.1;.1],.3,0,'lqgn5')
        figI = figI + 3;
        for (i = 1:5)
            load(sprintf('lqgn%d',i));
            figure(figI);
            subplot(2,1,1); plot(t,x(1,:),col(i)); hold on;
            subplot(2,1,2); plot(t,x(2,:),col(i)); hold on;

            figure(figI+1);
            plot(t,u,col(i)); hold on;
            ceff(i) = sqrt(mean(u.^2));
        end
        figure(figI); legend('\sigma^2=.01','\sigma^2=.03','\sigma^2=.05','\sigma^2=.1','\sigma^2=.3');
        subplot(2,1,1); xlabel('Time (s)'); ylabel('Position');
        title('Inverted pendulum trajectories for different noise levels (LQG Control)');
        subplot(2,1,2); xlabel('Time (s)'); ylabel('Angle (rad)');
        figure(figI+1); legend('\sigma^2=.01','\sigma^2=.03','\sigma^2=.05','\sigma^2=.1','\sigma^2=.3');
        xlabel('Time (s)'); ylabel('Control effort');
        title('Control effort for different noise levels (LQG Control)');
        figure(figI+2); plot(N,ceff);
        title('Average control effort for different noise levels (LQG Control)');
        xlabel('Noise'); ylabel('Average control effort');
        disp('LQG noise vs control effort:');
        disp([N ceff]);        
    end
    
    if (sim(9))
        % Human: length
        figI = figI + 3;
        h1x = zeros(4,length(ti));
        h1u = zeros(1,length(ti));
        for (i = 1:5)
            load(sprintf('hum1%d',i'));
            h1x = h1x+x(:,ti);
            h1u = h1u+u(ti);
        end
        h1x = h1x/5; h1u = h1u/5;
        ceff(1) = sqrt(mean(h1u.^2));
        h2x = zeros(4,length(ti));
        h2u = zeros(1,length(ti));
        for (i = 1:5)
            load(sprintf('hum2%d',i'));
            h2x = h2x+x(:,ti);
            h2u = h2u+u(ti);
        end
        h2x = h1x/5; h2u = h2u/5;
        ceff(2) = sqrt(mean(h2u.^2));
        h3x = zeros(4,length(ti));
        h3u = zeros(1,length(ti));
        for (i = 1:5)
            load(sprintf('hum3%d',i'));
            h3x = h3x+x(:,ti);
            h3u = h3u+u(ti);
        end
        h3x = h3x/5; h3u = h3u/5;
        ceff(3) = sqrt(mean(h3u.^2));
        figure(figI);
        subplot(2,1,1); plot(t(ti),h1x(1,:),'r'); hold on;
        plot(t(ti),h2x(1,:),'g'); plot(t(ti),h3x(1,:),'b');
        subplot(2,1,2); plot(t(ti),h1x(2,:),'r'); hold on;
        plot(t(ti),h2x(2,:),'g'); plot(t(ti),h3x(2,:),'b');
        figure(figI+1); plot(t(ti),h1u,'r'); hold on;
        plot(t(ti),h2u,'g'); plot(t(ti),h3u,'b');
        
        figure(figI); legend('l=1','l=.75','l=.5');
        subplot(2,1,1); xlabel('Time (s)'); ylabel('Position');
        title('Inverted pendulum trajectories for different lengths (Human Control)');
        subplot(2,1,2); xlabel('Time (s)'); ylabel('Angle (rad)');
        figure(figI+1); legend('l=1','l=.75','l=.5');
        xlabel('Time (s)'); ylabel('Control effort');
        title('Control effort for different lengths (Human Control)');
        fprintf('Length vs control effort:\n');
        disp([L(1:3) ceff(1:3)]);
    end
    
    if (sim(10))
        % Human: observation position
        figI = figI + 3;
        h1x = zeros(4,length(ti));
        h1u = zeros(1,length(ti));
        for (i = 1:5)
            load(sprintf('humO1%d',i'));
            h1x = h1x+x(:,ti);
            h1u = h1u+u(ti);
        end
        h1x = h1x/5; h1u = h1u/5;
        ceff(1) = sqrt(mean(h1u.^2));
        h2x = zeros(4,length(ti));
        h2u = zeros(1,length(ti));
        for (i = 1:5)
            load(sprintf('humO2%d',i'));
            h2x = h2x+x(:,ti);
            h2u = h2u+u(ti);
        end
        h2x = h1x/5; h2u = h2u/5;
        ceff(2) = sqrt(mean(h2u.^2));
        h3x = zeros(4,length(ti));
        h3u = zeros(1,length(ti));
        for (i = 1:5)
            load(sprintf('humO3%d',i'));
            h3x = h3x+x(:,ti);
            h3u = h3u+u(ti);
        end
        h3x = h3x/5; h3u = h3u/5;
        ceff(3) = sqrt(mean(h3u.^2));
        h4x = zeros(4,length(ti));
        h4u = zeros(1,length(ti));
        for (i = 1:5)
            load(sprintf('humO4%d',i'));
            h4x = h4x+x(:,ti);
            h4u = h4u+u(ti);
        end
        h4x = h4x/5; h4u = h4u/5;
        ceff(4) = sqrt(mean(h4u.^2));
        h5x = zeros(4,length(ti));
        h5u = zeros(1,length(ti));
        for (i = 1:5)
            load(sprintf('humO3%d',i'));
            h5x = h5x+x(:,ti);
            h5u = h5u+u(ti);
        end
        h5x = h5x/5; h5u = h5u/5;
        ceff(5) = sqrt(mean(h5u.^2));
        figure(figI);
        subplot(2,1,1); plot(t(ti),h1x(1,:),'r'); hold on;
        plot(t(ti),h2x(1,:),'g'); plot(t(ti),h3x(1,:),'b');
        plot(t(ti),h4x(1,:),'c'); plot(t(ti),h5x(1,:),'m');
        subplot(2,1,2); plot(t(ti),h1x(2,:),'r'); hold on;
        plot(t(ti),h2x(2,:),'g'); plot(t(ti),h3x(2,:),'b');
        plot(t(ti),h4x(2,:),'c'); plot(t(ti),h5x(2,:),'m');
        figure(figI+1); plot(t(ti),h1u,'r'); hold on;
        plot(t(ti),h2u,'g'); plot(t(ti),h3u,'b');
        plot(t(ti),h4u,'c'); plot(t(ti),h5u,'m');
        
        figure(figI); legend('l0=1','l0=.75','l0=.5','l0=.25','l0=.1');
        subplot(2,1,1); xlabel('Time (s)'); ylabel('Position');
        title('Inverted pendulum trajectories for different observation lengths (Human Control)');
        subplot(2,1,2); xlabel('Time (s)'); ylabel('Angle (rad)');
        figure(figI+1); legend('l0=1','l0=.75','l0=.5','l0=.25','l0=.1');
        xlabel('Time (s)'); ylabel('Control effort');
        title('Control effort for different observation lengths (Human Control)');
        fprintf('Observation Length vs control effort:\n');
        disp([L ceff]);
    end
end
