% ee150_chemical2.m
%  Sample inputs are 5e-5, 3e-5, 5e-5, [1e8; 1e-3; 1e-2; 1e-1]
function Y = ee150_chemical2(sub, enzyme1, enzyme2, k)
dt = .1;
eps = 1e-7;
Y = zeros(5,1);
Y(1,1) = sub;      
Y(2,1) = enzyme1;  
Y(3,1) = enzyme2;

i=1;
% Create your loop here
while (Y(1,i) > eps && Y(2,i) > eps && Y(3,i) > eps)
    Y(1,i+1) = Y(1,i) - k(1)*Y(1,i)*Y(2,i)*Y(3,i)*dt + k(2)*Y(4,i)*dt;
    Y(2,i+1) = Y(2,i) - k(1)*Y(1,i)*Y(2,i)*Y(3,i)*dt + k(2)*Y(4,i)*dt + k(4)*Y(4,i)*dt;
    Y(3,i+1) = Y(3,i) - k(1)*Y(1,i)*Y(2,i)*Y(3,i)*dt + k(2)*Y(4,i)*dt + k(3)*Y(4,i)*dt;
    Y(4,i+1) = Y(4,i) + k(1)*Y(1,i)*Y(2,i)*Y(3,i)*dt - k(2)*Y(4,i)*dt - k(3)*Y(4,i)*dt - k(4)*Y(4,i)*dt;
    Y(5,i+1) = Y(5,i) + k(3)*Y(4,i) + k(4)*Y(4,i)*dt;
    Y(:,i)
    i = i+1;
end

% Generate time vector - you will need to modify the following line.
t = 0:dt:(i-1)*dt;

figure;
plot(t,Y(1,:),'r'); 
hold on;  % Plot the following concentrations on the same figure;
plot(t,Y(2,:),'b');
plot(t,Y(3,:),'g');
plot(t,Y(4,:),'c');
plot(t,Y(5,:),'m');
end
