% Determinate simulation of model described in Gardner 2000.
function gardnerDeterministic(T,init,alpha1,alpha2,beta,gamma)
    
    dim = [1 1];
    if isnan(init)
        init = [.1 .3 .5 .8 1 1.2 1.5 1.7 2]; 
        init = [init; ones(1,length(init))];
        dim = [3 3];
    end
        
    fn = @(t,y) gardnerModel(t,y,alpha1,alpha2,beta,gamma);
    
    maxT = 0;
    maxY = 0;
    for i = 1:size(init,2)
        subplot(dim(1),dim(2),i);
        [t,y] = ode45(fn,[0 T],init(:,i));   
        plot(t,y);
        maxT = max(maxT,t(end));
        maxY = max(maxY,max(max(y)));
    end
    
    for i = 1:size(init,2)
        subplot(dim(1),dim(2),i);
        axis([0 maxT 0 maxY+.1]);
        xlabel('t'); ylabel('Concentration');
    end
    legend('[u]','[v]');
end