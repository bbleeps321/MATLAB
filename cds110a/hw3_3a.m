clear; close all;
M = 10; m = 80; J = 100;
c = .1; l = 1; gamma = .01; g = 9.8;
Mt = M + m;
Jt = J + m*l^2;
mu = Mt*Jt - (m*l)^2;
A = [0 0 1 0; 0 0 0 1;...
     0 m^2*l^2*g/mu -c*Jt/mu -gamma*l*m/mu;...
     0 Mt*m*g*l/mu -c*l*m/mu -gamma*Mt/mu]
B = [0; 0; Jt/mu; m*l/mu]
K = [-15.3 1730 -50 443];
Aprime = A-B*K
eigenvalues = eig(Aprime)