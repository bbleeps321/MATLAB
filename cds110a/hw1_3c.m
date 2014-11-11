function hw1_3c(kp, ki)
    m = 1;
    a = .1;
    w = [.01 .1 3.3 10];
    vpp = zeros(1,4);
    figure;
    for (i = 1:4)
        odefun = @(t,v) [0 1; -ki/m -(a+kp)/m]*[v(1); v(2)] + [0; ki*sin(w(i)*t)/m];
        [tsol vsol] = ode45(odefun, [0 3000], [0;0]);
        subplot(2,2,i);
        plot(tsol, vsol(:,1));
        title(sprintf('w=%f',w(i)));
        xlabel('time (s)');
        ylabel('Speed (m/s)');
        mid = floor(size(vsol,1)/2);
        secondHalf = vsol(mid:end,1);
        vpp(i) = max(secondHalf) - min(secondHalf);
    end
    vpp
    figure;
    loglog(w,vpp);
    title('Frequency response');
    xlabel('Angular frequency (rad/s)');
    ylabel('Peak-to-peak amplitude (m/s)');
end