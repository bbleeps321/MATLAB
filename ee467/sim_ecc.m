% Simulates with Hamming(7,4)
function ber = sim_ecc(msg,SNR)
    n = 7; k = 4; L = size(msg,1);
    
    % Hamming Encode
    G = [1 0 1 1 0 0 0; 
         0 1 1 0 1 0 0; 
         1 1 0 0 0 1 0; 
         1 1 1 0 0 0 1];
    
    msg_tx = zeros(L,n);
    for (i = 1:L)
        msg_tx(i,:) = bin(msg(i,:)*G);
    end
    
    % Add noise
    noise = gen_noise(size(msg_tx),SNR);
    msg_rx_ecc = bin(noise + msg_tx);
    
    % Hamming Decode
    H = [1 0 0 1 0 1 1; 
         0 1 0 0 1 1 1; 
         0 0 1 1 1 0 1];
    msg_rx = zeros(size(msg)); % message decoded, after ecc
    for (i=1:L)
        e = bin(H*msg_rx_ecc(i,:)');
        if (sum(e) ~= 0)
            error = findcol(H,e); % find column in H matching check result
            msg_rx_ecc(i,:) = bin(msg_rx_ecc(i,:) + ones(1,n).*(1:n==error));
        end
        msg_rx(i,:) = msg_rx_ecc(i,k:n);
    end
    
    % Count errors
    err_cnt = sum(sum(abs(msg_rx - msg)));
    ber = err_cnt/prod(size((msg)));
end

% G = [1 1 0 1 0 0 0;
%          0 1 1 0 1 0 0; 
%          1 1 1 0 0 1 0; 
%          1 0 1 0 0 0 1];
% H = [1 0 0 1 0 1 1; 
%          0 1 0 1 1 1 0; 
%          0 0 1 0 1 1 1];