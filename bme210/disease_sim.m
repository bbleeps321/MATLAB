% Does a simulation with the specified parameters and returns
% the number of people in each group for each day of the simulation.
% Column index is the day of the data point. Values are from START of the
% day (i.e. index 1 is initial, index 2 is start of day 2 or end of day 1).
% So, for ND days of simulation, ND+1 columns will be returned where the
% first column is day 0, second column is after 1 day, etc.
%
% Each row represents the population group.
% 1 = NH, 2 = NI, 3 = NC, 4 = NHI.
%
% For readability, we denote random variables in the code with a _ suffix.
function data = disease_sim(N,a1,a2,b1,b2,c1,c2,DT,NH,NI,NC,NHI,ND)
    % initialize populations
    M1 = zeros(1,NH);
    IM1 = zeros(1,NH);
    M2 = -floor((a2-a1+1)*rand(1,NI))-a1;
    IM2 = zeros(1,NI);
    M3 = floor((b2-b1+1)*rand(1,NC))+b1;
    IM3 = zeros(1,NC);
    M4 = zeros(1,NHI);
    IM4 = -floor((c2-c1+1)*rand(1,NHI))-c1;
    M = [M1 M2 M3 M4];
    IM = [IM1 IM2 IM3 IM4];
    
    % simulate
    for (day = 1:ND)
        % Randomly expose
        for (i=1:N/2)
            dt_ = floor(rand+DT);
            if (dt_)
                i_ = floor(N*rand)+1;
                j_ = floor(N*rand)+1;
                while (j_ == i_)
                    j_ = floor(N*rand)+1;
                end
                
                % Infect J if I contagious and J is healthy w/o immunity.
                if ((M(i_)>0) && (M(j_)==0) && (IM(j_)>=0))
                    M(j_) = -floor((a2-a1+1)*rand)-a1;  % infect
                % Infect I if J contagious and I is healthy w/o immunity.
                elseif ((M(j_)>0) && (M(i_)==0) && (IM(i_)>=0))
                    M(i_) = -floor((a2-a1+1)*rand)-a1;  % infect
                end
            end
        end
        
        % Record populations
        NH(day+1) = sum((M==0)&(IM>=0));
        NI(day+1) = sum(M<0);
        NC(day+1) = sum(M>0);
        NHI(day+1) = sum((M==0)&(IM<0));        
        
        % Update
        for (i=1:N)
            if (M(i)==0)        % healthy, so increment IM
                IM(i) = IM(i)+1;
            elseif (M(i)>0)     % contagious, decrement M
                M(i) = M(i)-1;
                if (M(i)==0)    % move to NHI group if M at 0
                    IM(i)=-floor((c2-c1+1)*rand)-c1;
                end
            else                % infected, increment M
                M(i) = M(i)+1;
                if (M(i)==0)    % move to NC group if M at 0
                    M(i) = floor((b2-b1+1)*rand)+b1;
                end
            end
        end
    end
    
    data = [NH;NI;NC;NHI];
end