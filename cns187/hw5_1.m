%% 1.1 Plot dataset (decision boundaries drawn separately)
clear all; close all;

%% Data set 1
load dataset_1;

x1 = Xtr(:,find(ytr));
x0 = Xtr(:,find(~ytr));
% x1 = [Xtr(1,:).*ytr'; Xtr(2,:).*ytr'];
% x0 = [Xtr(1,:).*(~ytr'); Xtr(2,:).*(~ytr')];

figure(1);
scatter(x1(1,:),x1(2,:),[],'b','filled'); hold on;
scatter(x0(1,:),x0(2,:),[],'r','filled');
xlabel('x1'); ylabel('x2'); title('Dataset 1 with Decision Boundaries');
legend('y = 1','y = 0');

%% Data set 2
load dataset_2;

x1 = Xtr(:,find(ytr));
x0 = Xtr(:,find(~ytr));

figure(2);
scatter(x1(1,:),x1(2,:),[],'b','filled'); hold on;
scatter(x0(1,:),x0(2,:),[],'r','filled');
xlabel('x1'); ylabel('x2'); title('Dataset 2 with Decision Boundaries');
legend('y = 1','y = 0');