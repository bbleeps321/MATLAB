function hw5c()
    N = 100;
    a1 = 3; a2 = 9;
    b1 = 12; b2 = 14;
    c1 = 5; c2 = 15;
    DT = .45;
    NH = 99; NI = 0; NC = 1; NHI = 0;
    ND = 250; NSIM = 100;
    
    % plotting
    t = 0:ND;
    
    subplot(2,2,1);
    title('Number of Healthy People (w/o immunity) over Time');
    xlabel('Days Elapsed');
    ylabel('Number of People');

    subplot(2,2,2);
    title('Number of Infected People over Time');
    xlabel('Days Elapsed');
    ylabel('Number of People');
    
    subplot(2,2,3);
    title('Number of Contagious People over Time');
    xlabel('Days Elapsed');
    ylabel('Number of People');
    
    subplot(2,2,4);
    title('Number of Healthy People (w/ immunity) over Time');
    xlabel('Days Elapsed');
    ylabel('Number of People');
    
    % For storing histogram data.
    histData = zeros(4,1);    
    for (i=1:NSIM)
        data=disease_sim(N,a1,a2,b1,b2,c1,c2,DT,NH,NI,NC,NHI,ND);
        for (j = 1:4)
            subplot(2,2,j);
            hold on;
            plot(t,data(j,:),'k');
            % save number on day 250 for histogram
            histData(j,i)=data(j,end);
        end
    end
    
    % Display histograms
    bins = 20;
    figure;
    subplot(2,2,1);
    hist(histData(1,:),bins);
    title('Distribution of Healthy People (w/o immunity) on Day 250');
    xlabel('Number of People on Day 250');
    ylabel('Count');

    subplot(2,2,2);
    hist(histData(2,:),bins);
    title('Distribution of Infected People on Day 250');
    xlabel('Number of People on Day 250');
    ylabel('Count');
    
    subplot(2,2,3);
    hist(histData(3,:),bins);
    title('Distribution of Contagious People on Day 250');
    xlabel('Number of People on Day 250');
    ylabel('Count');
    
    subplot(2,2,4);
    hist(histData(4,:),bins);
    title('Distribution of Healthy People (w/ immunity) on Day 250');
    xlabel('Number of People on Day 250');
    ylabel('Count');
end