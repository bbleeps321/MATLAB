function hw3_3b
    M = 10; m = 80; J = 100;
    c = .1; l = 1; gamma = .01; g = 9.8; f = 1;
    Mt = M + m;
    Jt = J + m*l^2;
    mu = Mt*Jt - (m*l)^2;
    tf = 30;
    K = [-15.3 1730 -50 443];
    th = [0 pi/2 pi -pi/2];
%     th = linspace(0,2*pi,10);
    p = 0;
    options = odeset('RelTol', 1e-4, 'AbsTol', [1e-5]);
    figure; hold on;
    for (i=1:length(p))
        for (j=1:length(th))
            [t,y] = ode45(@balance,[0,tf],[p(i);th(j);0;0],options,M,m,J,c,l,gamma,g,K,Mt,Jt);
%             [t,y] = ode45(@cartpend_model,[0,10],[p(i);th(j);0;0], options, M, m, J, g, l, c, gamma, f);
%             plot(y(:,1),y(:,2));
            plot(t,y(:,2));
        end
    end
%     figure;
%     plot(t,y(:,2));
    
function dx = balance(t,X,M,m,J,c,l,gamma,g,K,Mt,Jt)
    f = K*X;
    dx = cartpend_model(t,X,M,m,J,g,l,c,gamma,f);  

%     dx = zeros(4,1);
%     sth = sin(X(2));
%     cth = cos(X(2));
%     u = K*X;
%     denom1 = Mt-m*(m*l^2/Jt)*cth^2;
%     denom2 = Jt*(Mt/m)-m*(l*cth)^2;
%     dx(1) = X(3);
%     dx(2) = X(4);
%     dx(3) = (-m*l*sth*X(4)^2+m*g*(m*l^2/Jt)*sth*cth-c*X(3)-(gamma/Jt)*m*l*cth*X(4)+u)/denom1;
%     dx(4) = (-m*l^2*sth*cth*X(4)^2+Mt*g*l*sth-c*l*cth*X(3)-gamma*Mt/m*X(4)+l*cth*u)/denom2;

%     dx = dx - [0;0;1/denom1;l*cth/denom2]*K*X;
%     dx = dx - [0;0;Jt/mu;m*l/mu]*K*X;
