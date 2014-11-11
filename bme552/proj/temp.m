x=rand(10,5);
y=rand(10,5);
z=rand(10,5);
t=0:4;
h=uicontrol(gcf,'style','slider','units','pix','position',[100 5 300 20]);
set(h,'min',min(t),'max',max(t));
set(h,'callback','i=find(t==nearest(get(h,''value'')));plot3(x(:,i),y(:,i),z(:,i))');
for i=1:length(t)
    plot3(x(:,i),y(:,i),z(:,i));
    pause(1);
    set(h,'value',t(i));
end

% t = 1:100:7650;
% scales = 1:10:100;
% x = 1:4;
% [T,SCALES,X] = meshgrid(t,scales,x);
% tslice = []; 
% scalesslice = []; 
% xslice = 1:4;
% SGRAM = T + SCALES + X;
% surfHandles = slice(T,SCALES,X,SGRAM,tslice,scalesslice,xslice);
% set(surfHandles,'FaceAlpha',0.4,'EdgeAlpha',0.1)