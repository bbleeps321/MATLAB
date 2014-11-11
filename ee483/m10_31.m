wp = .2*pi, ws = .25*pi; dp = .002; ds = .002;
L = ceil(2*pi/(wp+ws+sqrt(2*pi*(ws-wp))));
[H I] = ifir(L, 'high', [wp ws], [dp ds])
subplot(1,2,1);