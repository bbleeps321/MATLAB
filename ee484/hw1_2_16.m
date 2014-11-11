i = 1:2:101;
A = 1;
P = (2*A./(i*pi)).^2;
for (j=1:length(i))
    fprintf('%d/T: %f\n',i(j),2*sum(P(1:j)));
end