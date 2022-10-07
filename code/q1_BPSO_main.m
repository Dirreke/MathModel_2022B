W = 1220;
H = 2440;
data = data_pre_fun("../data/dataA/dataA1.csv");
data(71:end,:)=[];
model = q1_create_restricted_model_fun(W,H,data);
CostFunction=@(x,k)q1_BPSO_cost_fun(model,x,k);


Max_iteration=1000; % Maximum number of iterations
noP=3000; % Number of particles
noV=length(model.lb);

ConvergenceCurves=zeros(8,Max_iteration);

%BPSO with s-shaped family of transfer functions
% [gBest1, gBestScore1 ,ConvergenceCurves(1,:)]=BPSO(noP,Max_iteration,1,CostFunction,noV);
[gBest2, gBestScore2 ,ConvergenceCurves(2,:)]=BPSO(noP,Max_iteration,2,CostFunction,noV);
% [gBest3, gBestScore3 ,ConvergenceCurves(3,:)]=BPSO(noP,Max_iteration,3,CostFunction,noV);
% [gBest4, gBestScore4 ,ConvergenceCurves(4,:)]=BPSO(noP,Max_iteration,4,CostFunction,noV);
% %BPSO with v-shaped family of transfer functions
% [gBest5, gBestScore5 ,ConvergenceCurves(5,:)]=BPSO(noP,Max_iteration,5,CostFunction,noV);
% [gBest6, gBestScore6 ,ConvergenceCurves(6,:)]=BPSO(noP,Max_iteration,6,CostFunction,noV);
% [gBest7, gBestScore7 ,ConvergenceCurves(7,:)]=BPSO(noP,Max_iteration,7,CostFunction,noV);
% [gBest8, gBestScore8 ,ConvergenceCurves(8,:)]=BPSO(noP,Max_iteration,8,CostFunction,noV); % VPSO

DrawConvergenceCurves(ConvergenceCurves,Max_iteration);