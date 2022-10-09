file = [
    "../data/dataA/dataA1.csv",
    "../data/dataA/dataA2.csv",
    "../data/dataA/dataA3.csv",
    "../data/dataA/dataA4.csv"
    ];

height = 2440;
width = 1220;

results = cell(length(file), 1);
ratios = zeros(length(file), 1);

for k = 1:length(file)
    [data_ori, material_index] = data_pre_fun(file(k));
    
    if length(material_index) ~= 1
        error("there is more than 1 material in dataA file");
    end
    tic 
    [bins,ratio] = q1_FFFD_fun(data_ori, width, height);
    toc

    fprintf("数据集dataA%d的最优排样策略的板材利用率为%.2f\n ",k,100*ratios(k));
end



