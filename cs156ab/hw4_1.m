fun = @(N) .05^2 - 8*log(4*(2*N)^10/.05)/N;
x = fzero(fun, 400000)