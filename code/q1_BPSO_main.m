width = 1220;
height = 2440;
data_ori = data_pre_fun("../data/dataA/dataA1.csv",1);
% data(71:end,:)=[];
model = q1_create_restricted_model_fun(width,height,data_ori);
CostFunction=@(x,k)q1_BPSO_cost_fun(model,x,k);


Max_iteration=1000; % Maximum number of iterations
noP=20; % Number of particles
noV=length(model.lb);

%% initial
init_points = false(noP,noV);
% bins = q1_FFF_fun(data_ori,width,height,0);
% xs = q1_bins2xs_fun(bins);
% x0 = [xs.alpha,xs.beta,xs.gamma];
% x0(model.index_delete) = [];
% init_points(1,:) = logical(x0);

for k = 1:noP
    bins = q1_FFF_fun(data_ori,width,height,0,1);
    xs = q1_bins2xs_fun(bins);
    x0 = [xs.alpha,xs.beta,xs.gamma];
    x0(model.index_delete) = [];
    init_points(k,:) = logical(x0);
end

%% solve
%BPSO with s-shaped family of transfer functions
% [gBest1, gBestScore1 ,ConvergenceCurves(1,:)]=BPSO(noP,Max_iteration,1,CostFunction,noV);
[gBest2, gBestScore2 ,ConvergenceCurves]=BPSO(noP,Max_iteration,2,CostFunction,noV,init_points);
% [gBest3, gBestScore3 ,ConvergenceCurves(3,:)]=BPSO(noP,Max_iteration,3,CostFunction,noV);
% [gBest4, gBestScore4 ,ConvergenceCurves(4,:)]=BPSO(noP,Max_iteration,4,CostFunction,noV);
% %BPSO with v-shaped family of transfer functions
% [gBest5, gBestScore5 ,ConvergenceCurves(5,:)]=BPSO(noP,Max_iteration,5,CostFunction,noV);
% [gBest6, gBestScore6 ,ConvergenceCurves(6,:)]=BPSO(noP,Max_iteration,6,CostFunction,noV);
% [gBest7, gBestScore7 ,ConvergenceCurves(7,:)]=BPSO(noP,Max_iteration,7,CostFunction,noV);
% [gBest8, gBestScore8 ,ConvergenceCurves(8,:)]=BPSO(noP,Max_iteration,8,CostFunction,noV); % VPSO

DrawConvergenceCurves(ConvergenceCurves,Max_iteration);