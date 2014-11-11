function hamming74_vs_hamming1511(L)
    msg = randi(2,L,4)-1;
    SNR = 1:.2:3;
    h74 = zeros(length(SNR),1);
    h1511 = zeros(length(SNR),1);
    for (i = 1:length(SNR))
         h74(i) = sim_ecc(msg,SNR(i));
         h1511(i) = sim_ecc1511(msg,SNR(i));
    end
    % Plot
    plot(SNR,h74,'r'); hold on;
    plot(SNR,h1511,'b'); hold off;
    title('Bit Error Rate for Hamming(7,4) and Hamming(15,11)');
    xlabel('SNR'); ylabel('Bit Error Rate');
    legend('Hamming(7,4)','Hamming(15,11)');
end