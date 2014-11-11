function m7_4
    w = 0:.01:2*pi;
    z = exp(1i*w);
    power = abs(H(z).*H(z.^-1) + H(-z).*H(-z.^-1));
    plot(w, power);
    axis([0 2*pi 0 2]);
    title('Power vs \omega');
    xlabel('\omega'); ylabel('Power');
end

function y = H(z)
    P = 1.5 + z.^-1 + 3.5*z.^-2 +3.5*z.^-3 + z.^-4 + 1.5*z.^-5;
    D = 6 + 5*z.^-2 + z.^-4;
    y = P./D;
end