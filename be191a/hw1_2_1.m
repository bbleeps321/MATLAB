clear; close all;
m = 100; e = .15*m;
c = [[.1:.1:.9]*m e (m-e)];
x = linspace(0,m,1000);
y = linspace(0,m,1000);

z = m-x'*y/m;
figure; C=contour(x,y,z,c);
clabel(C);
title('Unrestored'); xlabel('x (nM)'); ylabel('y (nM)');
hold on; plot(x,e*ones(1,length(x)),':k');
plot(x,(m-e)*ones(1,length(x)),':k');
plot([e e],[0 m],':k');
plot([(m-e) (m-e)],[0 m],':k');

z2 = m*z.^2./((m-z).^2+z.^2);
figure; C=contour(x,y,z2,c);
clabel(C);
title('Restored'); xlabel('x (nM)'); ylabel('y (nM)');
hold on; plot(x,e*ones(1,length(x)),':k');
plot(x,(m-e)*ones(1,length(x)),':k');
plot([e e],[0 m],':k');
plot([(m-e) (m-e)],[0 m],':k');