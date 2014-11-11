function y=Boltz(v)
m=1.67*32e-27;
T=300;
k=1.38e-23;
y= (((m)/(2*pi*k*T))^1.5)*4*pi*(v.^2).*exp(-(.5*m*v.^2)/(k*T));
end
