f = -.5:.001:.5;
L = 0.2;%*ones(1,length(f));
H = 1./((L+2i*pi*f).^2);
subplot(2,1,1);
plot(f,10*log10(abs(H).^2));
title('Squared magnitude of H');
xlabel('Normalized frequency');
ylabel('Squared magnitude in dB');
subplot(2,1,2);
plot(f,atan(imag(H)./real(H)));
title('Phase of H');
xlabel('Normalized frequency');