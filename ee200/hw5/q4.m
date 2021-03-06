t = -5:.001:10;
x1 = -t;
x2 = 2.5*t-7/2;
x3 = -7/2*t+17/2;
x4 = 15/4*t-53/4;
x5 = -3/4*t+19/4;
x6 = -t+6;
x = x1.*(0<=t & t<1) + x2.*(1<=t & t<2) + x3.*(2<=t & t<3) + x4.*(3<=t & t<4) + x5.*(4<=t & t<5) + x6.*(5<=t & t<6);
plot(t,x);
title('Convolution of x1 and x2');