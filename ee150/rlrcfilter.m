% bode plot for inductor (high pass filter)
format long
R = 1000;
L = .1;
logf = .0001:.1:10;
f = 10.^logf;
w = 2*pi*f;
H = (j*w*L./(R + j*w*L)); % transfer function
semilogx(f,20*log10(abs(H)));

% bode plot for capacitor (low pass filter)
format long
R = 1000;
C = 1e-6;
logf = .1:.01:5;
f = 10.^logf;
w = 2*pi*f;
H = ((-j./(w*C))./(R - j./(w*C))); % transfer function
%H = 1./(1+(j*w*R*C));
semilogx(f,20*log10(abs(H)));

% band pass filter
format long
R = 100;
C = 1e-9;
L = 1e-2;
logf = .0001:.1:10;
f = 10.^logf;
w = 2*pi*f;
H = R./(R +(j*w*L) - j./(w*C)); % transfer function
%H = 1./(1+(j*w*R*C));
semilogx(f,20*log10(abs(H)));