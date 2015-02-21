% Example where linear classifier better than decision tree.
figure;
scatter(1:10,2:11,'r'); hold on;
scatter(1:10,0:9,'b');
plot(1:10,1:10,'k--') % linear boundary.
plot([1 1.5 1.5 2.5 2.5 3.5 3.5 4.5 4.5 5.5 5.5 6.5 6.5 7.5 7.5 8.5 8.5 9.5 9.5 10],...
    [1 1 2 2 3 3 4 4 5 5 6 6 7 7 8 8 9 9 10 10],'g--'); % tree boundary
legend('y = 1','y = 0', 'Linear classifier boundary','Decision tree boundaries');
xlabel('x1'); ylabel('x2');