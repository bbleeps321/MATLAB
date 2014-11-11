function hw6()
    dh = .5;
    D = 6.5;
    C0 = 2;         % Concentration at origin (constant)
    Cb = 0;         % Concentration at boundaries (constant)
    T = 120;        % Simulation length in hours
    dt = dh*dh*.25/D;   % Set so we get alpha = .25
    
    % Set up x, y, t vectors
    x = -25:dh:25;
    y = -25:dh:25;
    t = 0:dt:T;
    
    % Initial and boundary conditions
    N = length(x);
    C = zeros(N,N); % (x,y,t). Origin is (25,25)
    x0 = find(x==0); y0 = find(y==0);   % Origin index
    C(x0,y0) = C0;
    
    % For recording C at 12h, 24h, 120h;
    C12 = zeros(N,N);
    C24 = zeros(N,N);
    C120 = zeros(N,N);
    % For recording concentration at 12mm and 6mm from implant
    C6m = 0; C12m = 0;
    
    % Simulation loop
    for (ti=1:(T/dt+1))
        % Record value if at a key time (12h, 24h, 120h)
        if (ti*dt == 12)        C12 = C;
        elseif (ti*dt == 24)    C24 = C;
        elseif (ti*dt == 120)   C120 = C;
        end
        
        % Record C at 6mm and 12mm from implant.
        % We take along one axis, since it should be radially symmetric.
        C6m(ti) = C(x0+6/dh,y0);
        C12m(ti) = C(x0+12/dh,y0);
        
        % Vectorize indices for speed.
        % Boundaries don't change
        i = 2:(N-1); i1 = 3:N; i_1 = 1:(N-2);
        j = 2:(N-1); j1 = 3:N; j_1 = 1:(N-2);
        dC = C(i1,j)+C(i_1,j)+C(i,j1)+C(i,j_1)-4*C(i,j);
        C(i,j)=C(i,j)+(D*dt/dh^2)*dC;
        
        % Enforce boundary conditions
        C(x0,y0)=C0;
        % Boundaries defaulted to 0 in next time step
    end
    
    % Outputs    
    % Display C6m and C12m at t=120h
    fprintf('Concentration 6mm from implant at t=120hr: %f\n', C6m(end));
    fprintf('Concentration 12mm from implant at t=120hr: %f\n', C12m(end));
    
    % Cross section at y=0 for t=12,24,120h
    figure;
    plot(x,C12(:,y0),'r');
    hold on;
    plot(x,C24(:,y0),'g');
    plot(x,C120(:,y0),'b');
    title('Concentrations at Along X-Axis at Y=0');
    xlabel('x (mm)'); ylabel('Concentration (\mug/g)');
    legend('t=12hr','t=24hr','t=120hr');
    
    % Plot C6m and C12m over t
    figure;
    plot(t,C6m,'b');
    hold on;
    plot(t,C12m,'r');
    title('Concentrations at Distance Away From Implant');
    xlabel('Time (hr)'); ylabel('Concentration (\mug/g)');
    legend('6mm from Implant','12mm from Implant');
    
    % Plot Ratio of C12m/C6m from t = 1 to 120h
    figure;
    i = find(t==1):find(t==120);
    plot(t(i),C12m(i)./C6m(i));
    axis([1 120 0 .8]);
    title('Ratio of C(12mm)/C(6mm) for 1h\leqt\leq120h');
    xlabel('Time (hr)'); ylabel('Ratio');
    
    % Mesh plot at t=120h
    figure;
    mesh(x,y,C120);
    axis([-25 25 -25 25 0 2]);
    title('Concentration at t = 120hr');
    xlabel('X Position (mm)');ylabel('Y Position (mm)');
    zlabel('Concentration (\mug/g)');
end