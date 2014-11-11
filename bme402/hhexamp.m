function hhexamp
    %Constants set for all Methods
    Cm=0.01; % Membrane Capcitance uF/cm^2
    dt=0.04; % Time Step ms
    t=0:dt:25; %Time Array ms
    I=0.1; %External Current Applied
    ENa=55.17; % mv Na reversal potential
    EK=-72.14; % mv K reversal potential
    El=-49.42; % mv Leakage reversal potential
    gbarNa=1.2; % mS/cm^2 Na conductance
    gbarK=0.36; % mS/cm^2 K conductance
    gbarl=0.003; % mS/cm^2 Leakage conductance
    V(1)=-60; % Initial Membrane voltage
    m(1)=am(V(1))/(am(V(1))+bm(V(1))); % Initial m-value
    n(1)=an(V(1))/(an(V(1))+bn(V(1))); % Initial n-value
    h(1)=ah(V(1))/(ah(V(1))+bh(V(1))); % Initial h-value
    for i=1:length(t)-1
    %Euler method to find the next m/n/h value
    m(i+1)=m(i)+dt*((am(V(i))*(1-m(i)))-(bm(V(i))*m(i))); 
    n(i+1)=n(i)+dt*((an(V(i))*(1-n(i)))-(bn(V(i))*n(i)));
    h(i+1)=h(i)+dt*((ah(V(i))*(1-h(i)))-(bh(V(i))*h(i)));
    gNa=gbarNa*m(i)^3*h(i);
    gK=gbarK*n(i)^4;
    gl=gbarl;
    INa=gNa*(V(i)-ENa);
    IK=gK*(V(i)-EK);
    Il=gl*(V(i)-El);
    %Euler method to find the next voltage value
    V(i+1)=V(i)+(dt)*((1/Cm)*(I-(INa+IK+Il)));
    end

    plot(t,V);
end

function a=am(v) %Alpha for Variable m
a=0.1*(v+35)/(1-exp(-(v+35)/10));
end
function b=bm(v) %Beta for variable m
b=4.0*exp(-0.0556*(v+60));
end
function a=an(v)%Alpha for variable n
a=0.01*(v+50)/(1-exp(-(v+50)/10));
end
function b=bn(v) %Beta for variable n
b=0.125*exp(-(v+60)/80);
end
function a=ah(v) %Alpha value for variable h
a=0.07*exp(-0.05*(v+60));
end
function b =bh(v) %beta value for variable h
b=1/(1+exp(-(0.1)*(v+30)));
end