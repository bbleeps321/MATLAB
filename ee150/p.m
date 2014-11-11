% prob of molecule having certain v
function prob = p(v)
    m = 32*1.67e-27;
    T = 300;
    K = 1.38e-23;
    prob = ((m/(2*pi*K*T))^(3/2)*4*pi) * v^2 * exp(-(m*v^2)/(2*K*T));
end