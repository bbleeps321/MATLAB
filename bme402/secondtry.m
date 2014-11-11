%BME402 Project 2
%
%N is input lines, W is weight matrix, sparsity of inputs/outputs is
%precentage of 1s in the N values. 
%threshold = N*s
N=100; %Number of input lines
W=zeros(N,N);
L=5; %length
s=0.1;
for i=1:L
    X(:,i)=Ns2x(100,s);
    Y(:,i)=Ns2x(100,s);
end
    [Xrows Xcols]=find(X==1);
    [Yrows Ycols]=find(Y==1);
    
    Xsorted=reshape(Xrows,10,5);
    Ysorted=reshape(Yrows,10,5);
for i=5
     for j=1:10
        W(Xsorted(j,i),Ysorted(:,i))=1;
     end
end

t=N*s; %threshold
Ypredict=X'*W;



Ypredict=Ypredict';

pcolor(Y);
colormap(gray(2));
figure
pcolor(Ypredict);
colormap(gray(2));