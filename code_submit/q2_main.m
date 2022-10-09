%% data initial
file = [
    "../data/dataB/dataB1.csv", 
    "../data/dataB/dataB2.csv", 
    "../data/dataB/dataB3.csv", 
    "../data/dataB/dataB4.csv", 
    "../data/dataB/dataB5.csv"
    ];

width = 1220;
height = 2440;
max_item_number = 1000;
max_item_area = 250e6;

results = cell(length(file), 1);
ratios = zeros(length(file), 1);
num_platess = zeros(length(file), 1);
parfor k = 1:length(file)
    [data_ori, material_index] = data_pre_fun(file(k));

    [batches,ratio,num_plates] = q2_FS(data_ori,width,height,max_item_number,max_item_area);
    results{k} = batches;
    ratios(k) = ratio;
    num_platess(k) = num_plates;

    
    fprintf("数据集dataB%d的最优组批排样策略的板材利用率为%.2f\n ",k,100*ratios(k));
end
