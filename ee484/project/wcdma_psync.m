% Generates the primary sync sequence.
function psync = wcdma_psync()
    a = [1, 1, 1, 1, 1, 1, -1, -1, 1, -1, 1, -1, 1, -1, -1, 1];
    psync = (1+1i)*[a, a, a, -a, -a, a, -a, -a, a, a, a, -a, a, -a, a, a];
end