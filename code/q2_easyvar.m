W = 1220;
H = 2440;
file_path = "../data/dataB/dataB1.csv";
data = data_pre_fun(file_path);
n = size(unique(data(:, 8)), 1);
n_vars = length(model.lb);

model = q2_create_nl_model_fun(W, H, data);

alpha = easyvar(n, n, "alpha");
beta = easyvar(n, n, "beta");

alpha = reshape(alpha, 1, n^2);
beta = reshape(beta, 1, n^2);

x = [alpha, beta];
x(model.index_delete) = [];
