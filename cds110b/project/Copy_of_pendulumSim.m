% PENDULUMSIM  Simulates inverted pendulum.
%   PENDULUMSIM(MODE,L,L0,X0,SIGMA,DELAY,FILE) simulates the
%   inverted pendulum in the specified mode with length L, observation 
%   length L0, initial state vector X0 (4x1), noise power SIGMA,
%   delay DELAY. Results are saved to FILE.mat.
%
%   MODE can be one of 3 values: 0 for manual control, 1 for LQR control,
%   and 2 for LQG control. When MODE is 1 or 2 (automatic control), the
%   left and right arrow keys can be used to "hit" the pendulum with noise.
%   Noise is applied to all states.
%
%   L0 should be a value between 0 and 1. For LQG control the system is
%   observing the pendulum at a length L0*L. For manual control the
%   pendulum is drawn only to length L0*L but has the dynamics of a
%   pendulum with length L, simulating an occluded top.
%
%   SDELAY and ADELAY will be approximated in the simulation based the time
%   discretization.
function pendulumSim(simMode,Length,obsLength,initDefl,noisevar,del,savename)
    close all;
    warning off all;
    global mode;
    global x; global data; global lastX; global lastT;
    global u;
    global t; % Timer
    global l; global l0;
    global dt; global ti; % Time step and current time index
    global K;
    global klqg;
    global M; global m; global g;
    global sigma;
    global C;
    global delay;
    global filename;
    sigma = noisevar;
    dt = .025;
    l = Length;
    l0 = obsLength;
    filename = savename;
    x = initDefl;
    lastX = 0; lastT = 0;
    data = [x; x; 0]; % 1-4: state; 5-8: state estimate; 9: u
    mode = simMode;
    delay = del;
    u = 0;
    M = 1; m = .1; g = 9.8;
    ti = 0;
    t = timer('ExecutionMode','fixedRate','Period',dt,...
                'TimerFcn',@timerFn,'StopFcn',@stopFn);
            
    switch (mode)
        case 1
            A = [0 0 1 0; 0 0 0 1; 0 -g*m/M 0 0; 0 g*(M+m)/(M*l) 0 0];
            B = [0; 0; 1/M; -1/(M*l)];
            C = eye(4);
            R = 1;
            Q = C'*C;
            K = lqr(A,B,Q,R);
        case 2
            A = [0 0 1 0; 0 0 0 1; 0 -g*m/M 0 0; 0 g*(M+m)/(M*l) 0 0];
            B = [0; 0; 1/M; -1/(M*l)];
            C = [1 l0*l 0 0];
            R = 1;
            Q = C'*C;
            QXU = blkdiag(Q,R);
            QWV = noisevar*eye(5);
            klqg = lqg(ss(A,B,C,0),QXU,QWV);
    end

    % Start simulation
    start(t);
return

function timerFn(timerHandle, evt)
    global x; global u; global l; global dt; global ti;
    drawGraphics(x);
    x = simulateStep(x,u,l);
    title('Press Spacebar to end','Color','w');
    text(0,-.5,sprintf('t=%f, x=%f, theta=%f',dt*ti,x(1),x(2)*180/pi),...
        'HorizontalAlignment','center','Color','g');
return

function stopFn(timerHandle, evt)
    global data; global dt; global ti; global filename;
    global l; global l0;
    title('Done','Color','w');
    t = 0:dt:ti*dt;
    
    figure;
    subplot(4,1,1); plot(t,data(1,:));
    xlabel('Time (s)'); ylabel('Position');
    subplot(4,1,2); plot(t,data(2,:));
    xlabel('Time (s)'); ylabel('Angle (rad/s)');
    subplot(4,1,3); plot(t,data(3,:));
    xlabel('Time (s)'); ylabel('Velocity');
    subplot(4,1,4); plot(t,data(4,:));
    xlabel('Time (s)'); ylabel('Angular velocity (rad/s)');
    
    x = data(1:4,:);
    xhat = data(5:8,:);
    u = data(9,:);
    
    save(filename,'t','x','xhat','l','l0','u');
return

function x2=simulateStep(x,u,l)
    global mode;
    global dt;
    global t; global ti;
    global K; global klqg;
    global m; global M; global g;
    global sigma;
    global C;
    global data;
    global delay; global dt;
    d = m+M-m*cos(x(2))^2;
    
    y = xSensed();
    x2 = zeros(4,1);
    switch (mode)
        case 0
%             x2(1) = x(1);
%             x2(2) = x(2)+x(4)*dt;
%             x2(3) = x(3);%+(L*m*x(4)^2*sin(x(2))-g*m*cos(x(2))*sin(x(2)))/d*dt;
%             x2(4) = x(4)+(-l*m*x(4)^2*cos(x(2))*sin(x(2))+g*(M+m)*sin(x(2)))/(d*l)*dt;
            x2(1) = x(1)+x(3)*dt;
            x2(2) = x(2)+x(4)*dt;
            x2(3) = x(3)+(u+l*m*x(4)^2*sin(x(2))-g*m*cos(x(2))*sin(x(2)))/d*dt;
            x2(4) = x(4)+(-u*cos(x(2))-l*m*x(4)^2*cos(x(2))*sin(x(2))+g*(M+m)*sin(x(2)))/(d*l)*dt;
        case 1
            u = -K*y;
            x2(1) = x(1)+x(3)*dt;
            x2(2) = x(2)+x(4)*dt;
            x2(3) = x(3)+(u+l*m*x(4)^2*sin(x(2))-g*m*cos(x(2))*sin(x(2)))/d*dt;
            x2(4) = x(4)+(-u*cos(x(2))-l*m*x(4)^2*cos(x(2))*sin(x(2))+g*(M+m)*sin(x(2)))/(d*l)*dt;
        case 2
            if (ti < floor(delay/dt)+1)
                x0 = zeros(4,1);
            else
                x0 = data(5:8,ti - floor(delay/dt));
            end
            x0 = data(5:8,end);
            uout = lsim(klqg,C*y*ones(2,1),0:dt:dt,x0);
            u = uout(end);
            x2(1) = x(1)+x(3)*dt;
            x2(2) = x(2)+x(4)*dt;
            x2(3) = x(3)+(u+l*m*x(4)^2*sin(x(2))-g*m*cos(x(2))*sin(x(2)))/d*dt;
            x2(4) = x(4)+(-u*cos(x(2))-l*m*x(4)^2*cos(x(2))*sin(x(2))+g*(M+m)*sin(x(2)))/(d*l)*dt;
    end
    ti = ti + 1;
    data(:,end+1) = [x2; y; u];
    
    % Check if pendulum has fallen
    if (abs(x2(2)) > pi/2)
        x2
        stop(t);
    end
return

% Gets y value including and sensor delay and noise
function y = xSensed()
    global delay;
    global data;
    global dt; global ti;
    global sigma;
    if (ti < floor(delay/dt))
        y = zeros(4,1);
    else
        y = data(1:4,ti - floor(delay/dt) + 1);
    end
    y = y + normrnd(0,sigma,4,1); % Noise hitting all states
return

function drawGraphics(x)
    global l; global l0; global mode;
    figure(1); hold off; %clf reset
    setupGCF();
    
    drawnow
    xMin = -1.5; xMax = 1.5; cartWidth = .25; cartHeight = .1;
    cla reset;axis([xMin,xMax,-.5,1.5]); axis('off')
    set(1,'Color','k');

    % Draw bottom
    % line([xMin,xMax],[0,0],'EraseMode','xor','LineStyle','-','Color','w');
    line([xMin,xMax],[-cartHeight,-cartHeight],...
        'EraseMode','xor','LineStyle','-','Color','w');

    % Draw cart
    cartXLeft = x(1)-cartWidth/2;
    cartXRight = x(1)+cartWidth/2;
    line([cartXLeft,cartXRight],[-cartHeight,-cartHeight]/2,...
        'EraseMode','xor','LineStyle','-','Color','r','LineWidth',15);
    
    % Draw pendulum
    if (mode == 0)
        L = l*l0;
    else
        L = l;
    end
    pendXBot = x(1);
    pendXTop = x(1)+L*sin(x(2));
    pendYBot = 0;
    pendYTop = L*cos(x(2));
    line([pendXBot,pendXTop],[pendYBot,pendYTop],...
        'EraseMode','xor','LineStyle','-','Color','b','LineWidth',5);
return

function setupGCF()
    set(gcf, 'WindowButtonMotionFcn', @mouseMove);
    set(gcf,'KeyPressFcn',@keyDown)
return

function mouseMove(src, event)
    global mode;
    global x; global dt; global lastX; global lastT; global l; global t;
    if (mode ~= 0)
        return
    end
    C = get (gca, 'CurrentPoint');
    T = t.TasksExecuted*dt;
    dT = max(T-lastT,dt);
%     v = (x(1)-lastX)/dT;
    x(1) = C(1);
    x(3) = (x(1) - lastX)/dT;
    x(4) = -x(3)/(l/2)*dt;
    x(2) = x(2) + x(4)*dt;
    lastT = T;
return

function keyDown(src, event)
    global t; global mode; global x;
    switch (event.Key)
        case 'space'
            stop(t);
        case 'leftarrow'
            if (mode ~= 0)
                x = x - .1*ones(4,1);
            end
        case 'rightarrow'
            if (mode ~= 0)
                x = x + .1*ones(4,1);
            end
    end
return