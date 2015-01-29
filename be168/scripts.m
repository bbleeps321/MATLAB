%% Balanced promoter strength.
alpha1 = 2.5; alpha2 = 2.5;
beta = 2; gamma = 2;
T = 25;
figure(99); clf;
gardnerDeterministic(T,nan,alpha1,alpha2,beta,gamma);
figure(100); clf;
gardnerStateSpace(alpha1,alpha2,beta,gamma);

%% Imbalanced promoter strength.
alpha1 = 2.5; alpha2 = .25;
beta = 2; gamma = 2;
T = 25;
figure(99); clf;
gardnerDeterministic(T,nan,alpha1,alpha2,beta,gamma);
figure(101); clf;
gardnerStateSpace(alpha1,alpha2,beta,gamma);

%% Larger bistability with larger repressor synthesis rates alpha
alpha1 = 25; alpha2 = 25;
beta = 2; gamma = 2;
T = 25;
range = [linspace(0,50,30);linspace(0,50,30)];
figure(101); clf;
[x,y,uu,vv]=gardnerStateSpace(alpha1,alpha2,beta,gamma,range);
% gardnerDeterministic(T,nan,alpha1,alpha2,beta,gamma);
h=streamline(x,y,uu,vv,10,20); h.Color='magenta';
h=streamline(x,y,uu,vv,30,5); h.Color='magenta';
h=streamline(x,y,uu,vv,20,22); h.Color='cyan';

%% Larger bistability with more cooperativity beta and gamma
alpha1 = 2.5; alpha2 = 2.5;
beta = 10; gamma = 10;
T = 25;
% range = [linspace(0,50,30);linspace(0,40,30)];
figure(101); clf;
[x,y,uu,vv]=gardnerStateSpace(alpha1,alpha2,beta,gamma);
% gardnerDeterministic(T,nan,alpha1,alpha2,beta,gamma);
% h=streamline(x,y,uu,vv,10,20); h.Color='magenta';
% h=streamline(x,y,uu,vv,30,5); h.Color='magenta';
% h=streamline(x,y,uu,vv,20,22); h.Color='cyan';

%% Other
y0 = [2.5;2.5];
alpha1 = 2.40; alpha2 = 2.6;
beta = 2; gamma = 2;
T = 25;
figure(102);
gardnerDeterministic(T,y0,alpha1,alpha2,beta,gamma);
figure(103); clf;
[x,y,uu,vv]=gardnerStateSpace(alpha1,alpha2,beta,gamma);