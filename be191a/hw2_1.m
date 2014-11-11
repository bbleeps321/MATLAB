clear; close all;
load hw2_data;

idx = find(C);
% tHigh = t(idx);
% CHigh = C(idx);

figure;
for (i=1:6)
    subplot(6,1,i);
    stairs(t,X(:,i));
    ylabel(sprintf('Count for X%d',i-1));
    axis([0 5 -.2 1.2]);
end
xlabel('Time (s)');
subplot(6,1,1); title('Species Counts over all Time');

figure;
for (i=1:6)
    subplot(6,1,i);
    stairs(t(idx),X(idx,i));
    ylabel(sprintf('Count for X%d',i-1));
    axis([0 5 -.2 1.2]);
end
xlabel('Time (s)');
subplot(6,1,1); title('Species Counts when C=1');


% plot(tHigh,[X5(idx) X4(idx) X3(idx) X2(idx) X1(idx) X0(idx)]);
% hold on; plot(tHigh,CHigh,'o');
% legend('X5','X4','X3','X2','X1','X0');
% xlabel('Time (s)'); ylabel('Count'); 
axis([0 5 -.2 1.2]);

n = zeros(length(t),1);
for (i=1:6)
    n = n+X(:,i)*2^(i-1);
end
% n = X5*2^5 + X4*2^4 + X3*2^3 + X2*2^2 + X1*2 + X0;
figure; stairs(t(idx),n(idx));
title('Counter Value over Time');
xlabel('Time (s)');
ylabel('Counter Value');
axis([0 5 0 20]);