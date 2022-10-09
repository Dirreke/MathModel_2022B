file = [
    "../data/dataA/dataA1.csv",
    "../data/dataA/dataA2.csv",
    "../data/dataA/dataA3.csv",
    "../data/dataA/dataA4.csv"
    ];
results = cell(length(file), 1);

for k = 1:length(file)
    [data_ori, material_index] = data_pre_fun(file(k));
    
    if length(material_index) ~= 1
        error("there is more than 1 material in dataA file");
    end
    
    height = 1220;
    width = 2440;
    
    bins_1 = q1_FFF_fun(data_ori, width, height);
    bins_2 = q1_FFF_fun(data_ori, height, width);
    
    if length(bins_1) > length(bins_2)
        results{k} = bins_2;
    else
        results{k} = bins_1;
    end
    save_to_file_fun(1, k,results{k}, material_index(1));
    draw_picture_fun(1, k);
    
end


