t = 0:.001:1;
tau = 19/20;
Pa1 = 75+593.75*(1-exp(-t/tau));
Pa2 = 231.708*exp(-t/tau);
Pa = Pa1.*(t<=.2) + Pa2.*(t>.2);
plot(t,Pa,'k');
title('Arterial Pressure vs Time');
xlabel('Time (s)'); ylabel('Arterial Pressure (mmHg)');