%% RUN_EXPERIMENT.m
% (c) California Institute of Technology
% P. Perona - 16 October, 2013
%


PARAMS.DT = 0.001; %% time bin size in seconds
%PARAMS.DT = 1; %% in seconds
PARAMS.T = 2; % length of observation in seconds
PARAMS.B = ceil(PARAMS.T/PARAMS.DT); % number of time bins in the simulation
MODEL.LAMBDA = [1 10]'; % firing rate of the neurons
%MODEL.LAMBDA = [1 10]';
MODEL.T = [-1.2 1.2]; % decision thresholds


N = 10^4; % number of runs of the diffusion 
PARAMS.DEBUG = 2;
PARAMS.PLOTS_DIR = './';
%% Generate synthetic data
%

X = generate_spike_trains(N,MODEL,PARAMS);
[N,N_NEURONS,B,N_CONDITIONS] = size(X);

%%

Z = compute_diffusions(X,MODEL,PARAMS);


%% infer which class it was
%[C0,RT0,N_AP0] = class_inference(X0,Z0,T0,T1,PARAMS);
[C,RT,N_AP] = class_inference(X,Z,MODEL,PARAMS);
RT00 = RT(find(C(:,1)==0),1); %% decision is 0 and class is 0
RT01 = RT(find(C(:,1)==1),1);
RT10 = RT(find(C(:,2)==0),2); %% decision is 0 and class is 1
RT11 = RT(find(C(:,2)==1),2);
RT0 = RT(find(C==0)); % response times when the underlying decision is 0
RT1 = RT(find(C==1)); % response times when the underlying decision is 1
N_AP0 = N_AP(find(C==0)); % n. action potentials when the decision was 0
N_AP1 = N_AP(find(C==1)); % n. action potentials when the decision was 1

figure(1); clf
for i=1:2,
    for j=1:2,
        RT_IJ{i,j} = RT(find(C(:,i)==(j-1)));
        text(i-1,j-1,num2str(100*length(RT_IJ{i,j})/N),'FontSize',24); 
    end;
end
xlim([-0.5 1.5]); ylim([-0.5 1.5]);
title('Confusion matrix'); xlabel('Inferred class'); ylabel('Ground truth class');
axis ij
%% plot  histograms of decision times

figure(2); clf
BINS = [0:1:PARAMS.B]*PARAMS.DT;

% histogram of response times when ground truth is 0 and decision is 0
subplot(2,2,1);
hist(RT00,BINS);
[n0,b0] = hist(RT00,BINS);
%bar(b0,n0,'r','LineWidth',3); 
xlim([0 4*median([RT00; RT11])]);

title('C=0, C_{est}=0','FontSize',16);

% response times when ground truth is 1 and decision is 1
subplot(2,2,2);
hist(RT11,BINS);
[n1,b1] = hist(RT11,BINS);
%bar(b1,n1,'g','LineWidth',3); 
xlim([0 4*median([RT00; RT11])]);
title('C=1, C_{est}=1','FontSize',16);

% class is 0, decision is 0 separated out by the n of action potentials
subplot(2,2,3);
CLR = jet(8);
TAG = {};
hold on
for k=1:8,
    n_spikes = k-1;
    i_k = find(N_AP(:,1)==n_spikes & C(:,1)==0);
    [n,b] = hist(RT(i_k,1),BINS);
    plot(b,n,'Color',CLR(k,:),'LineWidth',3);
    TAG{k} = ['k=' num2str(n_spikes)];
end;
legend(TAG,'Location','NE');
xlim([0 4*median([RT00; RT11])]);
title('C=0, C_{est}=0','FontSize',16);

% class is 1, decision is 1 separated out by the n. of action potentials
subplot(2,2,4);
CLR = jet(8);
TAG = {};
hold on
for k=1:8,
    n_spikes = k-1;
    i_k = find(N_AP(:,2)==n_spikes & C(:,2)==1);
    [n,b] = hist(RT(i_k,2),BINS);
    plot(b,n,'Color',CLR(k,:),'LineWidth',3);
    TAG{k} = ['k=' num2str(n_spikes)];
end;
legend(TAG,'Location','NE');
xlim([0 4*median([RT00; RT11])]);
title('C=1, C_{est}=1','FontSize',16);
orient landscape
print('-dpdf',[PARAMS.PLOTS_DIR 'DT_histograms']);

%% 


figure(3); clf
plot_decision_mechanics(X,Z,C,RT,N_AP,MODEL,PARAMS,0);
orient landscape
print('-dpdf',[PARAMS.PLOTS_DIR 'sample_diffusions_0']);

figure(4); clf
plot_decision_mechanics(X,Z,C,RT,N_AP,MODEL,PARAMS,1);
orient landscape
print('-dpdf',[PARAMS.PLOTS_DIR 'sample_diffusions_1']);
