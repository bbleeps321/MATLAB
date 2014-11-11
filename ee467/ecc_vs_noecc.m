% Simulates a noisy channel for a comm system with and without ECC.
% The ECC method used is Hamming (7,4).
% L is the number of nibbles sent (4 bits).
% Displays plot of BER vs SNR.
function ecc_vs_noecc(L)
    msg = randi(2,L,4)-1;
    SNR = 1:.2:3;
    raw = zeros(length(SNR),1);
    ecc = zeros(length(SNR),1);
    for (i = 1:length(SNR))
         raw(i) = sim_raw(msg,SNR(i));
         ecc(i) = sim_ecc(msg,SNR(i));
    end
    % Plot
    plot(SNR,raw,'r'); hold on;
    plot(SNR,ecc,'b'); hold off;
    title('Bit Error Rate for Hamming(7,4) and Uncoded');
    xlabel('SNR'); ylabel('Bit Error Rate');
    legend('Uncoded','Hamming(7,4)');
end