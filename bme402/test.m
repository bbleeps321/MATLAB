%BME402 Project 1
%Simulate a sphere neuron with Na+ and K+ channel and a lead current
%assume initial voltage, calculate component currents use diff eq with V
%and input current Im
%
%ms, mS, mV, uA, uF
%
%nA, mV, nF, ms, uS

clear; close all;

gk=36e-3; %mS                         <-- units
gna=120e-3; %mS
gleak=0.1e-3; %mS
Ek=-90; %mV reverse potentials
Ena=55; %mV
Eleak=-70; %mV
Cm=2e-3; %uF/cm^2
TMA=1; %cm^2 Total Membrane Area

%Im=input
%
%
%
%
et=30;
t=[0:0.001:et];
dt=0.001;
s=et/dt;
z=7; %injections

i_m=zeros(z,length(t));
V=zeros(z,length(t));
n=zeros(z,length(t));
m=zeros(z,length(t));
h=zeros(z,length(t));

a_n=zeros(z,length(t));
a_m=zeros(z,length(t));
a_h=zeros(z,length(t));

b_n=zeros(z,length(t));
b_m=zeros(z,length(t));
b_h=zeros(z,length(t));

i_k=zeros(z,length(t));
i_na=zeros(z,length(t));
i_L=zeros(z,length(t));
g_na=zeros(z,length(t));
g_k=zeros(z,length(t));
dvdt=zeros(z,length(t));
V(:,1)=-70;%mv                      <------


for k=1000:1100;
    i_m(1,k)=.05; %uA
    i_m(2,k)=.10; 
    i_m(3,k)=.15; 
    i_m(4,k)=.20;
    i_m(5,k)=.25;
    i_m(6,k)=.3;
    i_m(7,k)=.35;
end

V1=-70; %mV

an = -.01*(V1+60)./(exp(-(V1+60)/10)-1);
bn = .125*exp(-(V1+70)/80);
am = -.1*(V1+45)./(exp(-(V1+45)/10)-1);
bm = 4*exp(-(V1+70)/18);
ah = .07*exp(-(V1+70)/20);
bh = 1./(exp(-(V1+40)/10)+1);   
    
n(:,1)=an/(an+bn);
m(:,1)=am/(am+bm);
h(:,1)=ah/(ah+bh);

%calculating alpha and beta values. 

%Euler's loop integration to with alpha and beta values to update
%values of n, m, and h. 

for j=1:1:s; %ms
    dt=0.001; %ms

    %current injection for 0.1ms
    %i_m is the current injections
    %
    %alpha and beta
    a_n(:,j)=(-0.01.*(V(:,j)+60))./(exp(-(V(:,j)+60)./10)-1);
    a_m(:,j)=(-0.1.*(V(:,j)+45))./(exp(-(V(:,j)+45)./10)-1);  % <---
    a_h(:,j)=0.07*exp(-(V(:,j)+70)./20);
    b_n(:,j)=0.125*exp(-(V(:,j)+70)./80);
    b_m(:,j)=4*exp(-(V(:,j)+70)./18);
    b_h(:,j)=1./(exp(-(V(:,j)+40)./10)+1);   

    n(:,j+1)=((a_n(:,j).*(1-n(:,j)) - b_n(:,j).*n(:,j)).*dt) +n(:,j);
    m(:,j+1)=((a_m(:,j).*(1-m(:,j)) - b_m(:,j).*m(:,j)).*dt) +m(:,j);
    h(:,j+1)=((a_h(:,j).*(1-h(:,j)) - b_h(:,j).*h(:,j)).*dt) +h(:,j);

    g_k(:,j)=(n(:,j).^4*gk);
    g_na(:,j)=(m(:,j).^3.*h(:,j)*gna);


    i_k(:,j)=(g_k(:,j).*(V(:,j)-Ek));       %<----
    i_na(:,j)=(g_na(:,j).*(V(:,j)-Ena));
    i_L(:,j)=(gleak.*(V(:,j)-Eleak)); 

    %   i_m=i_k+i_na+i_L+i_C; %input
    %   iC = C dVdt

    % im=ik+ina+il+cdv/dt
    dVdt(:,j)= (i_m(:,j)-i_k(:,j)-i_na(:,j)-i_L(:,j))./Cm;

    V(:,j+1)=V(:,j)+(dVdt(:,j).*dt);

end

subplot(2,1,1);
plot(t,i_m);

subplot(2,1,2);
plot(t,V);
legend('0.05','0.1','0.15','0.2','0.25','0.3','0.35')
ylabel('mV')
xlabel('time ms')
   