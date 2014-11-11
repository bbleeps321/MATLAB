% Generates the noise of specified dimension with given SNR.
function noise = gen_noise(size, SNR)
    noise = (2*rand(size)-.5)/SNR;
end