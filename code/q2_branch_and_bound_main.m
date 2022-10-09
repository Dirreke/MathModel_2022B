W = 1220;
H = 2440;
file_path = "../data/dataB/dataB1.csv";
data = data_pre_fun(file_path);
model = q2_create_x_model_fun(W,H,data);

lb = model.lb;
ub = model.ub;
nonlcon = model.nonlcon;
    
optX = 1:n;  %存放最优解的x，初始迭代点(0,0)
optVal = 0;  %最优解
[x, fit, exitF, iter] = BranchBound1(c,A, b,[], [], lb, ub, optX, optVal, 0)