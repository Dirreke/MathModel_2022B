W = 1220;
H = 2440;
file_path = "../data/dataB/dataB1.csv";
data = data_pre_fun(file_path);
n = size(unique(data(:,8)),1);
model = q2_create_x_model_fun(W,H,data);


x0 = 1:n;
%%
options = optimoptions('fmincon','Display','iter');
fmincon(model.obj,x0,model.A,model.b,model.Aeq,model.beq,model.lb,model.ub,model.nonlcon,options);