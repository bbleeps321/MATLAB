clear; close all;

% Simulate associative net with N = 100, 20, and 200.
L = 5;
s = 0.1;
N = 100;
figure('Name', 'N=100');
[X Y Ypred] = simulateMarrNet(N,s,L);

N = 20;
figure('Name','N=20');
[X Y Ypred] = simulateMarrNet(N,s,L);

N = 200;
figure('Name', 'N=200');
[X Y Ypred] = simulateMarrNet(N,s,L);

N = 10;
L = 20;
figure('Name', 'N=10, L=20');
[X Y Ypred] = simulateMarrNet(N,s,L);

% Now look at effect of L on the net. Run for a range of L and calculate
% percentage error.
N = 100;
T = 3; % Number of trials for each L.
L = 1:100;
err = zeros(T,length(L));
for (i = 1:length(L))
    for (j = 1:T)
        [X Y Ypred] = simulateMarrNet(N,s,L(i),0);
   
        % Percent error:
        err(j,i) = 100*sum(sum(abs(Ypred-Y)))/(N*L(i));
    end
end
err = mean(err);

% Plot error against L.
figure;
plot(L,err,'k');
title('Percent Error vs. Number of Patterns');
xlabel('Number of Patterns');
ylabel('Percent Error');