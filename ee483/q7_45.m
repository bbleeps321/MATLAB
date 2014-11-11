subplot(2,2,1)
zplane([2 1.5 -3.2 -5.2 6.4 -5.2 -3.2 1.5 2])
title('Type 1');

subplot(2,2,2)
zplane([2 1.5 -3.2 -5.2 6.4 6.4 -5.2 -3.2 1.5 2]);
title('Type 2');

subplot(2,2,3)
zplane([2 1.5 -3.2 -5.2 6.4 0 -6.4 5.2 3.2 -1.5 -2]);
title('Type 3');

subplot(2,2,4)
zplane([2 1.5 -3.2 -5.2 6.4 -6.4 5.2 3.2 -1.5 -2]);
title('Type 4');