x = -pi:pi/64:pi;
y1 = 0*(x<0) + pi*(x>=0);
y2 = pi/2;
for (i=1:3)
    num = 2*i-1;
    y2 = y2 + 2*sin(num*x)/num;
end
y3 = pi/2;
for (i=1:5)
    num = 2*i-1;
    y3 = y3 + 2*sin(num*x)/num;
end
y4 = pi/2   ;
for (i=1:10)
    num = 2*i-1;
    y4 = y4 + 2*sin(num*x)/num;
end

plot(x,y1,'r');
hold on;
plot(x,y2,'g');
plot(x,y3,'b');
plot(x,y4,'k');

%{
%find max errors
disp('max for f1:');
disp(max(abs(y2-y1)));
disp('max for f2:');
disp(max(abs(y3-y1)));
disp('max for f3:');
disp(max(abs(y4-y1)));
%}