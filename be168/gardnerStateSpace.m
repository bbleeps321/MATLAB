function [x,y,uu,vv]=gardnerStateSpace(alpha1,alpha2,beta,gamma,range)
    if nargin < 5
        u = linspace(0,5,20);
        v = linspace(0,5,20);
    else
        u = range(1,:);
        v = range(2,:);
    end
    
    [x,y] = meshgrid(u,v);
    uu = zeros(size(x));
    vv = zeros(size(x));
    t = 0;
    for i = 1:numel(x)
        dy = gardnerModel(t,[x(i);y(i)],alpha1,alpha2,beta,gamma);
        uu(i) = dy(1);
        vv(i) = dy(2);
    end
    quiver(x,y,uu,vv,1.2,'k');
    h=streamline(x,y,uu,vv,4,1); h.Color='red';
    h=streamline(x,y,uu,vv,1,4); h.Color='blue';
    h=streamline(x,y,uu,vv,2.5,4.5); h.Color='green';
    h=streamline(x,y,uu,vv,3.5,3.5); h.Color='yellow';
    h=streamline(x,y,uu,vv,.1,1); h.Color='red';
    h=streamline(x,y,uu,vv,1,.1); h.Color='blue';
    h=streamline(x,y,uu,vv,4.5,2.5); h.Color='green';
    axis([min(u),max(u),min(v),max(v)]);
    xlabel('u'); ylabel('v');
    title('State space plot of Gardner model');
end