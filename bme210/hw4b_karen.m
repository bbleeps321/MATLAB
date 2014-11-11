%Karen Fang
%BME 210 D'Argenio
%HW4 Part 2
%3/29/11
function hw4b_karen
t = [1 3 5 14 18 24];
z = [.378141, .379223, .339644, .222273, .182757, .170694 ; .679187, .609917, .493551, .341565, .338849, .254918 ; .233948, .193099, .179902, 9.36e-2, 9.69e-2, 6.31e-2 ; .224695, .175813, .167266, .117034, 9.88e-2, 6.99e-2];
 
D = 10; % in mg
V = 25; % in liters
% a(i+1) = a(i) - O(i)*(a(i)-a(i-1))/(O(i)-O(i-1));
% O(K,V) = sum(z(t) - D*e^(-K*t))^2;
% for s=1:4
for j=1:4;
    i=2;
    K(1) = .07;
    K(2) = .05;
while abs(diffeq(z, D, t, K(i), j)) > 0.01
    K(i+1) = K(i) - diffeq(z, D, t, K(i), j)*(K(i)-K(i-1))/(diffeq(z, D, t, K(i), j)-diffeq(z, D, t, K(i-1), j));
    i=i+1;
end
r(j) = K(end);
end
tt = 1:.01:24;
C25 = (D/V)*exp(-r(1)*tt);
C26 = (D/V)*exp(-r(2)*tt);
C27 = (D/V)*exp(-r(3)*tt);
C28 = (D/V)*exp(-r(4)*tt);
 
disp(['for subject 25, K is estimated to be ', num2str(r(1))]);
disp(['for subject 26, K is estimated to be ', num2str(r(2))]);
disp(['for subject 27, K is estimated to be ', num2str(r(3))]);
disp(['for subject 28, K is estimated to be ', num2str(r(4))]);
 
z = [.378141, .379223, .339644, .222273, .182757, .170694 ; .679187, .609917, .493551, .341565, .338849, .254918 ; .233948, .193099, .179902, 9.36e-2, 9.69e-2, 6.31e-2 ; .224695, .175813, .167266, .117034, 9.88e-2, 6.99e-2];
 
subplot(2,2,1)
plot (tt, C25, 'r-', t, z(1,:), 'ko');
xlabel('Time(hrs)')
ylabel('Concentration of drug (mg/L)')
title('Subject 25 Concentration of drug vs Time')
hold on
 
subplot(2,2,2)
plot (tt, C26, 'r-', t, z(2,:), 'ko');
xlabel('Time(hrs)')
ylabel('Concentration of drug (mg/L)')
title('Subject 26 Concentration of drug vs Time')
hold on
 
subplot(2,2,3)
plot (tt, C27, 'r-', t, z(3,:), 'ko');
xlabel('Time(hrs)')
ylabel('Concentration of drug (mg/L)')
title('Subject 27 Concentration of drug vs Time')
hold on
 
subplot(2,2,4)
plot (tt, C28, 'r-', t, z(4,:), 'ko');
xlabel('Time(hrs)')
ylabel('Concentration of drug (mg/L)')
title('Subject 28 Concentration of drug vs Time')
hold on
 
end
 
 
function dOdK = diffeq (z, D, t, K, j)
V = 25;
    dOdK = sum(z(j,:).*t.*exp(-K*t)) - D/V*sum(t.*exp(-2*K*t));
end
