clear; close all;
Ti = 1/500;
P = tf(1,[1 1]);
kp = 10.^(-2:.01:10);
poles = zeros(4,length(kp));
for (i = 1:length(kp))
    C = tf([kp(i)*Ti 1],[Ti 0]);
    closedLoop = P*C/(1+P*C);
    temp = pole(closedLoop);
    poles(:,i) = [temp; zeros(4-length(temp))];
end

figure; subplot(2,1,1); 
semilogx(kp, real(poles)); ylabel('Real part of poles');
subplot(2,1,2);
semilogx(kp, imag(poles)); ylabel('Imaginary part of poles');
xlabel('kp');
% figure;
