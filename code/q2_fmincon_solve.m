W = 1220;
H = 2440;
file_path = "../data/dataB/dataB1.csv";
data = data_pre_fun(file_path);
n = size(unique(data(:,8)),1);
model = q2_create_nl_model_fun(W,H,data);

alpha = speye(n);
alpha = reshape(alpha,1,n^2);
beta = ~alpha;
x0 = [alpha,beta];
x0(model.index_delete) = [];
x0 = x0';
options = optimoptions('fmincon','Display','iter');
fmincon(model.obj,x0,model.A,model.b,model.Aeq,model.beq,model.lb,model.ub,model.nonlcon,options);
%% 
tic
model.obj(x0);
toc
tic
model.nonlcon(x0);
toc
tic
model.A*x0;
toc
tic
model.Aeq*x0;
toc