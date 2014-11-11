function Ntest(a,b,c,N)
    aabs = abs(fft(a,N));
    babs = abs(fft(b,N));
    cabs = abs(fft(c,N));
    figure;
    
    subplot(2,2,1);
    plot(aabs,'b');
    
    subplot(2,2,2);
    plot(babs,'r');
    
    subplot(2,2,3);
    plot(cabs,'g');
    
    subplot(2,2,4);
    plot(aabs,'b');
    hold on;
    plot(babs,'r');
    plot(cabs,'g');
    
    diff1 = sum(abs(aabs-babs));
    diff2 = sum(abs(aabs-cabs));
    
    fprintf('No match difference = %f\n',diff1);
    fprintf('Yes match difference = %f\n',diff2);
end