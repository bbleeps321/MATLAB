function m4_3
    close all;
    N=25;
    a = [.1 .3 .5 .7 .9];
    rgb = 'rgbmy';
    for (i=1:length(a))
        y = iir_sqrt(a(i),N);
        plot(1:N+1,sqrt(a(i))-y,rgb(i));
        hold on;
    end
    title('Error vs Iteration');
    xlabel('Iteration'); ylabel('Error');
    legend('\alpha=.1','\alpha=.3','\alpha=.5','\alpha=.7','\alpha=.9');
end

function y = iir_sqrt(a,N)
    y = zeros(N+1,1);
    y(1) = 1; % initial guess
    for (i=2:N+1)
        y(i) = a - y(i-1)^2 + y(i-1);
    end
end