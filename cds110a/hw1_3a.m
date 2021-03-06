beta = .1:.1:10;
open = 1./beta;
propgain = 10./(beta+10);
figure; hold on;
plot(beta, open, 'k-');
plot(beta, propgain, 'ko');
legend('Open loop', 'Proportional-gain loop');
title('Comparison of open-loop and proportional-gain feedback laws', 'Fontsize',13);
xlabel('\beta','Fontsize',13);
ylabel('v_{ss}/v_{ref}','Fontsize',13);