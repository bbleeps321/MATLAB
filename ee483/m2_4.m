function m2_4
    % (a)
    w0 = [0 .1 .2 .8 .9 1 1.1 1.2];
    A = 2; L = 40; phi = pi/4;
    for (i=1:8)
        subplot(4,2,i);
        sinPlot(L,A,w0(i)*pi,phi);
        title(sprintf('\\omega_0 = %f\\pi',w0(i)));
        xlabel('Time index n'); ylabel('Amplitude');
    end
    
    %(b)
    figure;
    w0 = [.3 .48 .45 .525 .7 .75];
    A = 1; L = 100; phi = 0;
    for (i=1:6)
        subplot(3,2,i); sinPlot(L,A,w0(i)*pi,phi);
        title(sprintf('\\omega_0 = %f\\pi',w0(i)));
        xlabel('Time index n'); ylabel('Amplitude');
    end
end

function sinPlot(L,A,w0,phi)
    n = 0:L;
    y = sin(w0*n+phi);    
    stem(n,y);
end