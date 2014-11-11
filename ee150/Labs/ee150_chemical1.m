% ee150_chemical1.m
dt = .01;        % calculate concentrations every dt seconds
duration = 100;  % stop after duration seconds
k = [1e6; 1e-4; 1e-1];         % reaction rate constants
Y = zeros(4,1);  % Initialize the Y-matrix as a 4x1 matrix.  The number
                 % of columsn will grow as we calculate the concentrations
                 % over time
Y(1,1) = 5e-7;   % initial substrate concentration             
Y(2,1) = 2e-7;   % initial enzyme concentration


for i = 1:(duration/dt) 
  % Modify the following lines to update the concentrations appropriately
  Y(1,i+1) = Y(1,i) - k(1)*Y(1,i)*Y(2,i)*dt + k(2)*Y(3,i)*dt;
  Y(2,i+1) = Y(2,i) - k(1)*Y(1,i)*Y(2,i)*dt + k(2)*Y(3,i)*dt + k(3)*Y(3,i)*dt;
  Y(3,i+1) = Y(3,i) + k(1)*Y(1,i)*Y(2,i)*dt - k(2)*Y(3,i)*dt - k(3)*Y(3,i)*dt;
  Y(4,i+1) = Y(4,i) + k(3)*Y(3,i)*dt;  
  Y(:,i+1)   % display the current concentrations (by leaving off the ';')
end

% Generate time vector - you will need to modify the following line.
t = 0:dt:duration;

figure;
plot(t,Y(1,:),'r+');
hold on;   % Plot the following concentrations on the same figure;
plot(t,Y(2,:),'b+');
plot(t,Y(3,:),'g+');
plot(t,Y(4,:),'y+');

