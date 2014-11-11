h=1;
R = 1e6;
C = 1e-5; % as C increases, charge rate decreases
V = 10;
a = 0;
b = 60;
m = (b-a)/h;
Q = zeros(1, m+1);
Q(1) = 0;
t = a:h:b;
for i = 1:m
    Q(i+1) = Q(i) - (h/(R*C)) * Q(i) + (V*h)/R; % numerical approx
end
Qex = C*V*(1 - exp(-t/(R*C))); % actual
% integration
I=[(1/h)*diff(Q),0];
disp( [t' Q' Qex'] )
subplot(1,2,1)
plot(t, Q, 'r')
xlabel( 'time in seconds' ), ylabel( 'charge on capacitor in coulombs' )
hold on
plot(t, Qex), hold off
subplot(1,2,2)
plot(t,I,'k')
xlabel( 'time in seconds' ), ylabel( 'curent in the circuit in amps' )