
data_ori = data_pre_fun("../data/dataA/dataA1.csv");
height = 1220;
width = 2440;
bins_1 = q1_FFF_fun(data_ori,width,height);

height = 2440;
width = 1220;

bins_2 = q1_FFF_fun(data_ori,width,height);
%% ²»Ðý×ª°æ±¾ + MILP 
bins_2 = q1_FFF_fun(data_ori,width,height,0);
xs = q1_bins2xs_fun(bins_2);
model=q1_create_restricted_model_fun(width,height,data_ori);
x0 = [xs.alpha,xs.beta,xs.gamma];
x0(model.index_delete) = [];

options = optimoptions('intlinprog','MaxTime',400,'RootLPAlgorithm','dual-simplex','Display','iter','CutGeneration','advanced');
test = intlinprog(model.obj,1:length(model.obj),model.A,model.b,model.Aeq,model.beq,model.lb,model.ub,x0,options);