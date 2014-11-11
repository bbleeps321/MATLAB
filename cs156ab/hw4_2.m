Nmax = 10000; dvc=50; delta = 0.05;
N=1:Nmax;
eps = zeros(Nmax,4);
mH = @(n) n.^dvc;
fc = @(e,n) sqrt((2*e+log(6*mH(2*n)/delta))/n) - e;
fd = @(e,n) sqrt((4*e*(1+e)+log(4/delta)+2*dvc*log(n))/(2*n)) - e;
eps(:,1) = sqrt(8*log(4*mH(2*N)/delta)./N);
eps(:,2) = sqrt(2*log(2*N.*mH(N))./N) + sqrt(2*log(1/delta)./N) + 1./N;
for (i=1:Nmax)
    fc2 = @(e) fc(e,N(i));
    fd2 = @(e) fd(e,N(i));
    eps(i,3) = fzero(fc2,0);
    eps(i,4) = fzero(fd2,0);
end

figure;
plot(N(3:end),eps(3:end,:));
xlabel('N'); ylabel('Generalization Error');
legend('Original','Rademacher Penalty','Parrondo and Van den Broek','Devroye');

eps(10000,:)
eps(5,:)