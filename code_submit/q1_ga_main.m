%% data
file = ["../data/dataA/dataA1.csv", "../data/dataA/dataA2.csv", "../data/dataA/dataA3.csv", "../data/dataA/dataA4.csv"];
data_ori = data_pre_fun(file(1), 1);
height = 2440;
width = 1220;
%% model
model = q1_create_restricted_model_fun(width, height, data_ori);
num = length(model.obj);


%% 定义遗传算法参数
NIND = 100; %个体数目
MAXGEN = 1000; %最大遗传代数
GGAP = 0.90; %代沟
px = 0.1; %交叉概率
pm = 0.007; %变异概率
ge_num = num;
trace = zeros(MAXGEN, ge_num); %寻优结果的初始值
tracei = zeros(MAXGEN, 1);
%% initial Chrom

for k = 1:NIND
    bins = q1_FFF_fun(data_ori, width, height, 0, 1);
    xs = q1_bins2xs_fun(bins);
    x0 = [xs.alpha, xs.beta, xs.gamma];
    x0(model.index_delete) = [];
    Chrom(k, :) = logical(x0);
end

%% 优化
obj = @(x, k)q1_BPSO_cost_fun(model, x, k);

gen = 0;
ObjV = obj(Chrom, gen)';

while gen < MAXGEN
    FitnV = ranking(ObjV); %分配适应度值
    Selch = select('sus', Chrom, FitnV, GGAP); %选择
    Selch = recombin('xovsp', Selch, 0.7); %重组
    Selch = mut(Selch, pm);
    %     Selch=mut(Selch);
    ObjVSel = obj(Selch, gen)'; %计算子代的目标函数值
    [Chrom, ObjV] = reins(Chrom, Selch, 1, [1, 1], ObjV, ObjVSel); %重插入子代到父代，得到新种群
    
    gen = gen + 1;
    gen
    %代计数器增加
    %获取每代的最优解及其序号，Y为最优解,I为个体的序号
    [Y, I] = min(ObjV);
    trace(gen, :) = Chrom(I, :); %记下每代的最优值
    tracei(gen, 1) = Y; %记下每代的最优值
end

figure;
plot(1:MAXGEN, tracei);
grid on
xlabel('遗传代数')
ylabel('解的变化')
title('进化过程')
answer = zeros(MAXGEN, 1);