h = .01;
R = 40;
L = 1; %as impedence increases, frequency increases
V = 10;
a = 0;
b = .8;
m = (b-a)/h;
I = zeros(1,m+1);
I(1) = 0;
t = a:h:b;
for i = 1:m
    I(i+1) = I(i) - ((h*R)/L)*I(i) + (V*h)/L;
end
Iex = (V/R)*(1 - exp(-t*R/L));
VL = [(1/h)*diff(I),0]*L;
format long
disp([t' I' Iex']);
subplot(1,2,1);
plot(t,I,'r');
xlabel('time in seconds'), ylabel('current in circuit');
hold on
plot(t, Iex), hold off
subplot(1,2,2);
plot(t,VL,'k');
xlabel('time in seconds'), ylabel('voltage on inductor');