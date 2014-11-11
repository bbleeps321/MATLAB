function hw6()
    dh = .5;
    D = 6.5;
    C0 = 2;         % Concentration at origin (constant)
    Cb = 0;         % Concentration at boundaries (constant)
    T = 12;        % Simulation length in hours
    dt = dh*dh*.25/D;   % Set so we get alpha = .25
    
    % Initial and boundary conditions
    C = zeros(51,51,1); % (x,y,t). Origin is (25,25)
    x0 = 25; y0 = 25;   % Origin
    C(x0,y0,1) = C0;
    
    % Simulation loop
    for (ti=1:T/dt)
        % Vectorize indices for speed.
        % Boundaries don't change
        i = 2:50; i1 = 3:51; i_1 = 1:49;
        j = 2:50; j1 = 3:51; j_1 = 1:49;
        dC = C(i1,j,ti)+C(i_1,j,ti)+C(i,j1,ti)+C(i,j_1,ti)-4*C(i,j,ti);
        C(i,j,ti+1)=C(i,j,ti)+(D*dt/dh^2)*dC;
        
        % Enforce boundary conditions
        C(x0,y0,ti)=C0;
        % Boundaries defaulted to 0 in next time step
    end
    
    x = -25:25; y = -25:25;
    mesh(x,y,C(:,:,end));
end