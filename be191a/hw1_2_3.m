clear; close all;

tf = .25;
e0 = 10; e1 = 100-e0;
x0 = [e1 e1 e0 e0; e1 e0 e0 e1; e0 e1 e1 e0; e0 e0 e1 e1];
figure;
for (i = 1:4)
    subplot(4,1,i);
    sol = gec2(x0(i,1),x0(i,2),x0(i,3),x0(i,4),tf);
    plot(sol.t,sol.sp_13);
    axis([0 tf 0 100]);
    ylabel('Concentration (nM)');    
end
subplot(4,1,1);
title('Output Z1 in response to input 00');
subplot(4,1,2);
title('Output Z1 in response to input 01');
subplot(4,1,3);
title('Output Z1 in response to input 10');
subplot(4,1,4);
title('Output Z1 in response to input 11');
xlabel('Time (s)');