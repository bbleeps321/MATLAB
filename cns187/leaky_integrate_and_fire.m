%%(c) California Institute of Technology
%  Pietro Perona - 5 Oct. 2011

EXPERIMENT_REPETITIONS = 1;
TIME_STEPS = 150; %% each is one millisecond long
INPUT_START = 20; %ms
INPUT_END = 100; %ms

RESTING_POTENTIAL = -70; %% mV
MAX_DEPOLARIZATION = 30; %% mV
THRESH = -30; %% mV
REFRACTORY_T = 5; %% ms

INPUT_CURRENT_MAGNITUDE = 13; % nA
INPUT_CURRENT_NOISE = 0; % nA
C = 1; % F
LEAK_RESISTANCE = 10; % nOhm




%%

figure(1); clf; grid on;

for e_i=1:EXPERIMENT_REPETITIONS,
    
    % Initialize the arrays - the input current
    INPUT_CURRENT = zeros(1,TIME_STEPS);
    INPUT_CURRENT(INPUT_START:INPUT_END) = INPUT_CURRENT_MAGNITUDE; %% current different from zero during stimulation
    INPUT_CURRENT = INPUT_CURRENT + INPUT_CURRENT_NOISE * randn(1,TIME_STEPS); %% add some noise 
    MEMBRANE_VOLTAGE = zeros(1,TIME_STEPS);
    MEMBRANE_VOLTAGE(1) = RESTING_POTENTIAL;
    
    subplot(3,1,2);
    plot([1 TIME_STEPS],RESTING_POTENTIAL*[1 1],'c','LineWidth',2); hold on;
    plot([1 TIME_STEPS],THRESH*[1 1],'m','LineWidth',2);  hold off;
    REFRACTORY_COUNTDOWN = 0;
    
    subplot(3,1,3);
    xlabel('Time (ms)','FontSize',18);
    ylabel('Iteration','FontSize',18);
    title('Action potential raster plot');
     
    % Compute the membrane voltage one time-step at a time
    for t=2:TIME_STEPS,
        
        % Plot the input current one dot at a time
        subplot(3,1,1);
        plot(t,INPUT_CURRENT(t),'b.','MarkerSize',10); hold off
        axis([0 TIME_STEPS -0.2 INPUT_CURRENT_MAGNITUDE*1.2]);
        ylabel('input current (nA)','FontSize',18);
         if t>2, 
             hold on; 
             title(['Input=' num2str(INPUT_CURRENT_MAGNITUDE) '\pm' num2str(INPUT_CURRENT_NOISE) ' nA '...
        '   R=' num2str(LEAK_RESISTANCE) 'n\Omega'],'FontSize',24);
         end;
        
         
        if REFRACTORY_COUNTDOWN==0, %If we are not in a refractory period
            LEAK_CURRENT = max((MEMBRANE_VOLTAGE(t-1)-RESTING_POTENTIAL) / LEAK_RESISTANCE,0);
            MEMBRANE_VOLTAGE(t) = MEMBRANE_VOLTAGE(t-1) + (INPUT_CURRENT(t-1)-LEAK_CURRENT)/C;
            %MEMBRANE_VOLTAGE(t) = max(MEMBRANE_VOLTAGE(t),RESTING_POTENTIAL);
        else, %% if we are within a refractory period
            MEMBRANE_VOLTAGE(t) = RESTING_POTENTIAL;
            REFRACTORY_COUNTDOWN = REFRACTORY_COUNTDOWN-1;
        end;
        
        % The cell will `fire' if the membrane potential has exceeded the
        % threshold
        if MEMBRANE_VOLTAGE(t)>THRESH,
            MEMBRANE_VOLTAGE(t) = MAX_DEPOLARIZATION;
            REFRACTORY_COUNTDOWN = REFRACTORY_T;
        end;
        subplot(3,1,2); hold on; plot(t-1:t,MEMBRANE_VOLTAGE(t-1:t),'k.-','MarkerSize',20); hold off
        axis([0 TIME_STEPS RESTING_POTENTIAL*1.2 MAX_DEPOLARIZATION*1.2]);
        %xlabel('time (ms)','FontSize',18);
        ylabel('membrane potential (mV)','FontSize',18);
        %pause(0.02);
        
        % Put down a dot in the raster plot if the cell just fired an
        % action potential
        if MEMBRANE_VOLTAGE(t)>THRESH,
            subplot(3,1,3); hold on;
            plot(t,e_i,'k.','MarkerSize',20); hold off;
            axis([0 TIME_STEPS 0 EXPERIMENT_REPETITIONS+1]);
        end;
        drawnow
    end;
    hold off
end;