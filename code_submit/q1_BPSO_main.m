width = 1220;
height = 2440;
data_ori = data_pre_fun("../data/dataA/dataA1.csv", 1);
model = q1_create_model_fun(width, height, data_ori);
CostFunction = @(x, k)q1_cost_fun(model, x, k);

Max_iteration = 1000; % Maximum number of iterations
noP = 20; % Number of particles
noV = length(model.lb);

%% initial
init_points = false(noP, noV);

for k = 1:noP
    bins = q1_FFFD_fun(data_ori, width, height, 0, 1);
    xs = q1_bins2xs_fun(bins);
    x0 = [xs.alpha, xs.beta, xs.gamma];
    x0(model.index_delete) = [];
    init_points(k, :) = logical(x0);
end

%% solve

[gBest2, gBestScore2, ConvergenceCurves] = BPSO(noP, Max_iteration, 2, CostFunction, noV, init_points);
DrawConvergenceCurves(ConvergenceCurves, Max_iteration);
