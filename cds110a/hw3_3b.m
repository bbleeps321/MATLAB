function hw3_3b
    tf = 10; M = 10; m = 80; J = 100;
    c = .1; l = 1; gamma = .01; g = 9.8;
    K = [-15.3 1730 -50 443];
    th = [.5 -.5 3 3.5]; p = 0;
    options = odeset('RelTol', 1e-3, 'AbsTol', [1e-3]);
    figure; hold on; col = 'rgbk';
    for (j=1:length(th))
        [t,y] = ode45(@balance,[0,tf],[p;th(j);0;0],options,M,m,J,c,l,gamma,g,K);
        plot(t,y(:,2),col(j));
    end
    
function dx = balance(t,X,M,m,J,c,l,gamma,g,K)
    f = -K*X;
    dx = cartpend_model(t,X,M,m,J,g,l,c,gamma,f);