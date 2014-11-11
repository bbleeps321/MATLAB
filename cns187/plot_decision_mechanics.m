function plot_decision_mechanics(X,Z,C,RT,N_AP,MODEL,PARAMS,CONDITION)
%% plot_decision_mechanics.m
% (c) California Institute of Technology
% P. Perona - 16 October, 2013
%

N_PLOTS = 12;

i_c = CONDITION+1;

[N,N_NEURONS,B,N_CONDITIONS] = size(X);
T = (1:B)*PARAMS.DT; %time axis

% Thresholds
T0=MODEL.T(1);
T1=MODEL.T(2);

%% compute rows and cols of subplots that are needed to display the data
ROWS = floor(sqrt(N_PLOTS));
COLS = ceil(N_PLOTS/ROWS);

MRT = median(RT(:,i_c));
MAXT = ceil( 2*MRT*PARAMS.DT);


for i_plot=1:N_PLOTS,
    N_SPIKES_TO_DECIDE = N_AP(i_plot,i_c);
    subplot(ROWS,COLS,i_plot);
    
    % plot the thresholds
    plot(T,T0*ones(1,B),'Color',0.8*[1 1 1], 'LineWidth',3); hold on
    plot(T,0*ones(1,B),'Color',0.5*[1 1 1], 'LineWidth',1);
    plot(T,T1*ones(1,B),'Color',0.8*[1 1 1], 'LineWidth',3);

    
    % put tau labels
    if RT(i_plot)*PARAMS.DT > MAXT/4,
        text(MAXT/6,T0,'\tau_0','FontSize',14,'BackgroundColor','w');
        text(MAXT/6,T1,'\tau_1','FontSize',14,'BackgroundColor','w');
    end;
    
    % plot the diffusion
    plot(T,Z(i_plot,:,i_c),'Color',[0.7 0.7 1], 'LineWidth',3);
    
    % plot the action potentials
    for i_n=1:N_NEURONS,
        i_spikes = find(squeeze(X(i_plot,i_n,:,i_c)))';
        if length(i_spikes)>0,
            plot([1 1]'*i_spikes*PARAMS.DT, 0.5*(i_n- (N_NEURONS/2))+ 0.2 * [1 -1]' * ones(size(i_spikes)), 'k', 'LineWidth', 2);
        end
    end
    ylim(1.5*[T0 T1]);
    xlim([0 MAXT]);
    
    % plot the decision times
    %i_decision = round(RT(i_plot,i_c)/PARAMS.DT); %% index of time bin when decision was taken
    if C(i_plot,i_c)>0, CLR = 'g'; YD=T1; else CLR='r'; YD=T0; end
    plot(RT(i_plot,i_c),YD,'.','Color',CLR,'MarkerSize',30);
    
    
    title(['RT=' num2str(RT(i_plot,i_c)*10^3) ' ms - ' num2str(N_SPIKES_TO_DECIDE) ' spikes'],'FontSize',14);
end;

% display and x and y labels
subplot(ROWS,COLS,(ROWS-1)*COLS+1);
xlabel('Time (s)','FontSize',18);
ylabel('R_t','FontSize',18);