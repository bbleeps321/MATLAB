% Calculates and plots the electric field distribution for a specific
% electrode.
% a = electrode radius (m)
% V0 = voltage at electrode
% rmaxF = factor of radius to simulate out to.
% hmax = height above electrode to simulate to.
% Returns x, y coordinate vectors and E magnitude.
function [x y z M] = electricField(a, V0, rmaxF, zmax)
    x = -rmaxF*a:a/50:rmaxF*a;
    y = x;
    z = 0:zmax/100:zmax;
    
    V = zeros(length(x),length(y),length(z));
    for (i = 1:length(x))
        for (j = 1:length(y))
            r = sqrt(x(i)^2+y(j)^2);
            V(i,j,:) = abs(2*V0/pi*asin(2*a./(sqrt((r-a)^2+z.^2)+sqrt((r+a)^2+z.^2))));
        end
    end
    
    % Plot
    M = zeros(size(V));
    
    % Calculate E from taking -gradient
    [FX, FY, FZ] = gradient(V);
    Ex = -FX;
    Ey = -FY;
    Ez = -FZ;
    
    % For intensity, only looking at magnitude.
    for (i = 1:size(V,1))
        for (j = 1:size(V,2))
            for (k=1:size(V,3))
                M(i,j,k) = norm([Ex(i,j,k) Ey(i,j,k) Ez(i,j,k)]);
            end
        end
    end
end