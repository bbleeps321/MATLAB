function plotIPulseVResp(t,V,I,c)
    subplot(2,1,1);
    plot(t,I,'k');
    axis([t(1) t(end) 0 2*max(I)]);
    title('Current Pulse'); xlabel('Time (ms)'); ylabel('Current (uA)');
    subplot(2,1,2);
    plot(t,V,c);
    title('Voltage Response'); xlabel('Time (ms)'); ylabel('Voltage (V)');
end