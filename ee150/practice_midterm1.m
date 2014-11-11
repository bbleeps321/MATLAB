r = .9;
dt = .1;
T = 10;
N = zeros(1,1);
N(1) = 10e11;

for (i=1:T/dt)
    N(i+1) = N(i) - r*N(i)*dt;
end

disp('Uranium left after 10 years:');
disp(N(i));

t = 0:dt:T;

plot(t,N, 'g');
xlabel('Years');
ylabel('Number of radioactive atoms left');
title('Decay of radioactive material');