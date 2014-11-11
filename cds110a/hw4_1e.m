eigenvalues = eig([0 1; -1 -1])
w0 = 1; z0 = .5; we = 2; ze = .5;
Aprime = [0 1 0 0; -w0^2 -2*z0*w0 w0^2-1 2*z0*w0; 0 0 -2*ze*we 1; 0 0 -we^2 0]
eigenvalues = eig(Aprime)