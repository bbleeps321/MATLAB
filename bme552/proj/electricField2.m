% Calculates and plots the electric field distribution for a specific
% electrode.
% a = electrode radius (m)
% V0 = voltage at electrode
% rmaxF = factor of radius to simulate out to.
% hmax = height above electrode to simulate to.
% Returns x, y coordinate vectors and E magnitude.
function [x y z M] = electricField2(a, V0, rmaxF, zmax)
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
    disp(max(max(max(M))))
    disp(max(max(M(:,:,2))))
    disp(max(max(M(:,:,50))))
    
    % Plot initially at height index 'init'.
    fig=figure('Name','Electric Field Intensity');
    init = 2;
    plt = mesh(x,y,M(:,:,init));    
    range = [min(x) max(x) min(y) max(y) 0 max(max(max(M)))];
    axis(range);
    title('Electric Field Intensity');
    xlabel('x'); ylabel('y'); zlabel('E (V/m)');

    % We add a slider on the side to adjust the height we're showing E for.
    t=uicontrol('style','text','position',[5 360 100 35],'String',...
        sprintf('Distance from Electrode: %f mm',z(2)*1000));
    h=uicontrol(gcf,'style','slider','units','pix','position',[5 75 20 275]);
    data = guidata(gcf);
    data.h = h;
    data.x = x;
    data.y = y;
    data.z = z;
    data.M = M;
    data.fig = fig;
    data.range = range;
    data.t = t;
    data.plt = plt;
    guidata(gcf, data);
    set(h,'value',init);
    set(h,'min',2,'max',length(z));
    set(h,'SliderStep',[1 1]/100);
    set(h,'callback','data = guidata(gcf); figure(data.fig); i=nearest(get(data.h,''value'')); data.plt = mesh(data.x,data.y,data.M(:,:,i)); disp(max(max(data.M(:,:,i)))); axis(data.range); title(''Electric Field Intensity''); xlabel(''x''); ylabel(''y''); zlabel(''E (V/m)''); set(data.t,''String'',sprintf(''Distance from Electrode: %f mm'',data.z(i)*1000)); drawnow');
end