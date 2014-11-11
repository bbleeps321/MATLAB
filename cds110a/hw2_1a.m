function hw2_1a
% x = linspace(-1,1,20);
% y = linspace(-1,1,20);
% U = zeros(length(x),length(y));
% V = zeros(length(x),length(y));
k = 250;
m = 1000;
a = .01;
c = 100;

% f = @(t,Y) [Y(2); -k/m*(Y(1) - a*Y(1)^3)-c/m*Y(2)];
phaseplot(@dx,[-15 15 20],[-15 15 20],1);
% y1 = linspace(-15,15,20);
% y2 = linspace(-15,15,20);
% 
% % creates two matrices one for all the x-values on the grid, and one for
% % all the y-values on the grid. Note that x and y are matrices of the same
% % size and shape, in this case 20 rows and 20 columns
% [x,y] = meshgrid(y1,y2);
% size(x);
% size(y);
% 
% u = zeros(size(x));
% v = zeros(size(x));
% 
% % we can use a single loop over each element to compute the derivatives at
% % each point (y1, y2)
% t=0; % we want the derivatives at each point at t=0, i.e. the starting time
% for i = 1:numel(x)
%     Yprime = f(t,[x(i); y(i)]);
%     u(i) = Yprime(1);
%     v(i) = Yprime(2);
% end
% 
% quiver(x,y,u,v,'r');
% axis tight equal;

% for (i = )
%     for (j=1:length(y))
%         U(i,j)=y(j);
%         V(i,j) = -x(i)-y(i);
% %         U(i,j) = y(j);
% %         V(i,j) = -k/m*(x(i) - a*x(i)^3)-c/m*y(j);
%     end
% end

% quiver(x,y,U,V,10);

function dydt=dx(t,Y)
    dydt(1) = Y(2);
    dydt(2)=-k/m*(Y(1) - a*Y(1)^3)-c/m*Y(2);
    dydt=dydt';
