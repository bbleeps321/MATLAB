wcdma_data = read_complex_binary('wcdma_2152p5_data.bin');
real_wcdma = real(wcdma_data);
temp_string = zeros(1,2*38400);
logging_codes = zeros(2,31*8);
a = 1;
for k = 1:(38400*2)
    temp_string(k) = real_wcdma(k);
end
for codegroup = 0:30
    for codeid = 0:7
        scramble = WCDMAScrCode(16*codegroup + 8*codeid);
        scramble = resample(scramble, 125, 48);
        correlation = xcorr(temp_string, scramble);
        correlation = abs(correlation);
        if(max(correlation)-min(correlation)> 3)
            logging_codes(1,a) = codegroup;
            logging_codes(2,a) = codeid;
            a = a+1;
        end
        plot(correlation);
    end
end

        