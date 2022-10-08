file = ["../data/dataA/dataA1.csv","../data/dataA/dataA2.csv","../data/dataA/dataA3.csv","../data/dataA/dataA4.csv"];
data_ori = data_pre_fun(file(1),1);
height = 2440;
width = 1220;
bins_2 = q1_FFF_fun(data_ori,width,height);

%% ²»Ðý×ª°æ±¾ + MILP 
bins_2 = q1_FFF_fun(data_ori,width,height,0);
[xs,bins] = q1_bins2xs_fun(bins_2);
model=q1_create_restricted_model_fun(width,height,data_ori);
x0 = [xs.alpha,xs.beta,xs.gamma]';
x0(model.index_delete) = [];

options = optimoptions('intlinprog','MaxTime',18000,'RootLPAlgorithm','dual-simplex','Display','iter','CutGeneration','advanced');
test = intlinprog(model.obj,1:length(model.obj),model.A,model.b,model.Aeq,model.beq,model.lb,model.ub,x0,options);

% % Why
% value_A = model.A * x0;
% value_b = model.b;
% value_Aeq = model.Aeq * x0;
% value_beq = model.beq;
% 
% value_A(value_A<0 ) = 0;










