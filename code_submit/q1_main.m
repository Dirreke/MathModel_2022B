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
    [bins_1,ratio_1] = q1_FFFD_fun(data_ori, width, height);
    [bins_2,ratio_2] = q1_FFFD_fun(data_ori, height, width);
    if ratio_1 < ratio_2
        ratios(k) = ratio_1;
        results{k} = bins_1;
    else
        ratios(k) = ratio_2;
        results{k} = bins_2;
    end

    fprintf("数据集dataA%d的最优排样策略的板材利用率为%.2f\n ",k,100*ratios(k));
end



