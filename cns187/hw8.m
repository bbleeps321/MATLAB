clear all;
close all;

p1 = [-1 -1 1 1 -1]';
p2 = [1 -1 1 -1 -1]';

% Train weight matrix for the two patterns in p.
W = zeros(5,5);
% W = 1/length(p) * p(1,:)'*p(2,:);
% W = rand(5,5) > .5;
% W = W - ~W;
for i=1:5
    for j=1:5
        W(i,j) = W(i,j) + p1(i)*p1(j) + p2(i)*p2(j);
%         W(i,j) = mean([p1(i)*p1(j) p2(i)*p2(j)]);
    end
end

%% Simulate different patterns.
clc;
p = [-1 1 1 1 -1; 1 1 1 -1 -1; -1 -1 1 -1 1; 1 1 1 1 -1]';
T = 10;
for i = 1:4
    x = p(:,i);
    disp(['Simulating for: x = [',num2str(x'),']']);
    X = SimulateHopfield(W,x,T)
    if isequal(X(:,end),p1)
        fprintf(['Matched [',num2str(p1'),']\n']);
    elseif isequal(X(:,end),p2)
        fprintf(['Matched [',num2str(p2'),']\n']);
    else
        fprintf('Failed to match pattern\n');
    end
    fprintf('\n~~~~~~~~~~~~~~~~~~~\n');
end
