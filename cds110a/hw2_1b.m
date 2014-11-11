u = 2.16; n=2;
f = @(t,Y) [u/(1+Y(2)^n)-Y(1); u/(1+Y(1)^n)-Y(2)];
y1 = linspace(0,2,30);
y2 = linspace(0,2,30);
[x,y] = meshgrid(y1,y2);
size(x);
size(y);
u = zeros(size(x));
v = zeros(size(x));
t=0;
for i = 1:numel(x)
    Yprime = f(t,[x(i); y(i)]);
    u(i) = Yprime(1);
    v(i) = Yprime(2);
end
quiver(x,y,u,v,2,'k');
title('Genetic Toggle Switch System Phase Plot');
xlabel('z1'); ylabel('z2');
streamline(x,y,u,v,0,1);
streamline(x,y,u,v,1,0);
streamline(x,y,u,v,.5,.5);
streamline(x,y,u,v,.4,.5);
streamline(x,y,u,v,.6,.5);
axis tight equal;