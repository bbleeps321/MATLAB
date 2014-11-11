% Simulates without any ECC
function ber = sim_raw(msg,SNR)
    % Transmitted signal unchanged, no coding
    msg_tx = msg;
    
    % Add noise
    noise = gen_noise(size(msg_tx),SNR);
    
    % Received is message, no decoding.
    msg_rx = bin(noise + msg_tx);
    
    % Count errors
    err_cnt = sum(sum(abs(msg_rx - msg)));
    ber = err_cnt/prod(size((msg)));
end