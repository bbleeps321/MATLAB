function m5_6
    disp('(a)');
    [G H] = doubleDFT([-3 2 4 -6 1 2], [2 -1 3 -4 5 6]);
    disp('G[k]');
    disp(G);
    disp('H[k]');
    disp(H);
    
    disp('(b)');
    [G H] = doubleDFT([5 -4 -2 6 1 3], [4 -5 5 1 -2 3]);
    disp('G[k]');
    disp(G);
    disp('H[k]');
    disp(H);
end

function [G H] = doubleDFT(g,h)
    x = g+j*h;
    N = length(x);
    X = fft(x);
    G = zeros(1,N);
    H = zeros(1,N);
    for (i=0:N-1)
        G(i+1) = .5*(X(i+1)+conj(X(mod(-i,N)+1)));
        H(i+1) = -.5*j*(X(i+1)-conj(X(mod(-i,N)+1)));
    end
end