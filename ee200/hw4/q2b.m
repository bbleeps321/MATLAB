n = -1:5;
a = 2;
x1 = a.^n .* (n >= 0);
x2 = a.^n.*(n >= 1);
y = x1-x2;
plot(n,y,'b.');