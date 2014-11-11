clear; close all;
tf = 1;
F = [2 5 8];
% F = 0:.01:10;
I = 5;
% k = 10;
% plot(F,99*F./(1*I*(F+I)));
% xlabel('[F]_0'); ylabel('Time to [I]=.99[I]_0');
% title('Effect of [F]_0 on Completion Time');

figure;
for (i=1:length(F))
    subplot(1,3,i);
    gec1(I,F(i),tf);
    hold on;
    plot([0 1],.01*F(i)*[1 1],':r');
    title(sprintf('[I]_0 = %dnM, [F]_0 = %dnM',I,F(i)));
    ylabel('Concentration (nM)');
    xlabel('Time (s)');
end
