file = ["../data/dataA/dataA1.csv","../data/dataA/dataA2.csv","../data/dataA/dataA3.csv","../data/dataA/dataA4.csv"];
results = cell(length(file),1);
for k = 1:length(file)
    data_ori = data_pre_fun(file(k));
    height = 1220;
    width = 2440;
    bins_1 = q1_FFF_fun(data_ori,width,height);

    height = 2440;
    width = 1220;

    bins_2 = q1_FFF_fun(data_ori,width,height);
    if length(bins_1) > length(bins_2)
        results{k} = bins_2;
    else
        results{k} = bins_1;
    end
end


save_to_file_fun(results{1},1);
draw_picture_fun();









