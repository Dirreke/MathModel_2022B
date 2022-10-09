file = ["../data/dataB/dataB1.csv","../data/dataB/dataB2.csv","../data/dataB/dataB3.csv","../data/dataB/dataB4.csv","../data/dataB/dataB5.csv"];

for k = 1:length(file)
    [data_ori, material_index] = data_pre_fun(file(3));
    width = 1220;
    height = 2440;
    max_item_number = 1000;
    max_item_area = 250e6;
    batches = q2_tanlan(file(k));
end



