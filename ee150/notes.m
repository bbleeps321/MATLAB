% Square root of 2 with Newton's method.
% See section 2.6.1 in text book.
format compact
a = 2;
x = a/2;
disp(' Newtons''s iteration for sqrt(2) ')
for t = 1:6
    x = (x + a/x)/2;
    disp( x )
end

disp( 'Matlab''s value: ' )
disp( sqrt(2) )
format

% Newton's method applied to solving the equation cos(x) = x^3.
% Actually solving for the roots of the equation cos(x) - x^3.
format compact
x = .5;
disp(' Newton''s iteration for solving cos(x) = x^3 ')
for i=1:6
    x = x - (cos(x) - x^3)/(-sin(x) - 3*x^2);
    disp(x);
end

format

% Solving differential equation dN/dR
h = 0.5;
r = 0.8;
a = 0;
b = 10;
m = (b-a)/h;
N = zeros(1,m+1);
N(1) = 1000;
t = a:h:b;

for i=1:m
    N(i+1) = N(i) + r*h*N(i);
end
Nex = N(1) * exp(r*t);
format bank
disp( [t' N' Nex'] )
plot(t,N), xlabel('Hours'), ylabel('Bacteria')
hold on % on the same graph, plot:
plot(t,Nex), hold off % don't plot on same anymore
format;


% Example of if-else statements, logical operators, etc.
disp('Random balance calculator');
bal = 15000 * rand;
if (bal < 5000)
    rate = 0.09;
elseif (bal < 10000)
    rate = 0.12;
else
    rate = 0.15;
end

format bank;
disp('The old balance is: ');
disp(bal);
disp('The rate is: ');
disp(rate);

newbal = bal + rate*bal;
disp('New balance is: ');
disp(newbal);
format;

% Example of a switch statement.
d = floor(3*rand) + 1;
switch (d)
    case (1)
        disp('a');
    case (2*1)
        disp('b');
    case (3)    
        disp('c');
end

% Another example of a switch statment.
d = floor(10*rand);  % some int b/w 0 and 10
switch (d)
    case {2, 4, 6, 8}
        disp('even number!');
    case {1, 3, 5, 7, 9}
        disp('odd number!');
    otherwise
        disp('must be 0');
end

% Projectile simulation
%Trajectory in constant acceleration in one direction

dt = .1;
g = 9.8;
a = 2;
b = 22;
m = (b-a)/dt;
y = zeros(1,m+1);
v = zeros(1,m+1);
v(1) = 100;
y(1) = 0;
t = a:dt:b;

for i=1:m
    v(i+1) = v(i) - g*dt;
    y(i+1) = y(i) + v(i)*dt;
end

disp('The final position is: ');
disp(y(b+1));

% Projectile simulation outputting when the object 
% is at maximum height and when it hits the ground.
g = .81;
v0 = input('Launch speed in m/s: ');
th0 = input('Launch angle in degress: ');
th0 = pi*th0/180;   % to radians

txMax = (2*v0/g)*sin(th0);
xmax = txmax*v0*cos(th0);

dt = tmax/100;
t = 0:dt:tmax;

x = v0*cos(th0) .*t;
y = v0*sin(th0) .*t - (g/2) .* t.^2;;

vx = v0*cos(th0);
vy = v0*sin(th0) - g.*t;

% menu input example
k = 0;
while k ~= 3
    k = menu('Click your option', 'Do this', 'Do that', 'Quit')
    if k == 1
        disp('Do this ... press any to continue');
        pause
    elseif k == 2
        disp('Do that ... press any to continue');
        pause
    end
end

% loop with newton's method to find zeros of function in f.m
steps = 0;
x = input('initial guess? ');
re = 1e-5;  % relative error
myrel = 1;
while (myrel > re && steps < 20)
    xold = x;
    x = x - f(x)/df(x);
    steps = steps+1;
    disp([x f(x)]);
    myrel = abs((x - xold)/x);
end
if (myrel <= re)
    fprintf('Zero found at x = %d\n', x);
else
    disp('Zero not found');
end

% sawtooth written as fourier series
t = 0:2e-6:2e-3;
vst = .5*ones(size(t));
for n=1:5
    vst = vst-(1/(n*pi))*sin(2000*n*pi*t);
end
subplot(1,2,1);
plot(t,vst);
axis([0 2e-3 -.5 1.5]);
for n=6:10
    vst = vst-(1/(n*pi))*(sin(2000*n*pi*t));
end
subplot(1,2,2);
plot(t,vst);
axis([0 2e-3 -.5 1.5]);

% advanced data structure
student(1).name = 'Carey';
student(1).age = 18;
student(2).name = 'David';
student(2).age = 16;

c(1,1) = {rand(3)};
c(1,2) = {char('Bongani', 'Thandeka')};
c(2,1) = {13};
c(2,2) = {student};