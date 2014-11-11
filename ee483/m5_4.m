N = 5; i = 0:N-1;
x_re = rand(1,N);
x_im = rand(1,N);
x = x_re + j*x_im
disp('fft(x[n])');
X=fft(x)

disp('x*[n] -> X*[mod(-k,N)]');
disp('fft(x*[n])');
fft(conj(x))
disp('X*[mod(-k,N)]');
conj(X(mod(-i,N)+1))

disp('x*[mod(-n,N)] -> X*[k]');
disp('fft(x*[mod(-n,N)])');
fft(conj(x(mod(-i,N)+1)))
disp('X*[k]');
conj(X)

disp('x_re[n] -> X_cs[k]');
disp('fft(x_re[n])');
fft(real(x))
disp('X_cs[k]');
.5*X+.5*conj(X(mod(-i,N)+1))

disp('x_im[n] -> X_ca[k]');
disp('fft(j*x_im[n])');
fft(j*imag(x))
disp('X_ca[k]');
.5*X-.5*conj(X(mod(-i,N)+1))

disp('x_cs[n] -> X_re[k]');
disp('fft(x_cs[n])');
fft(.5*x+.5*conj(x(mod(-i,N)+1)))
disp('X_re[k]');
real(X)

disp('x_ca[n] -> X_im[k]');
disp('fft(x_ca[n])');
fft(.5*x-.5*conj(x(mod(-i,N)+1)))
disp('j*X_im[k]');
j*imag(X)