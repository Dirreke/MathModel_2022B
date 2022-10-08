file = ["../data/dataB/dataB1.csv","../data/dataB/dataB2.csv","../data/dataB/dataB3.csv","../data/dataB/dataB4.csv","../data/dataB/dataB5.csv"];
% for k = 1:length(file)
%     data_ori = data_pre_fun(file(k));
% end
[data_ori, material_index] = data_pre_fun(file(1));
material_num = size(material_index,1);
material_data = material_index;
material_data(:,3) = zeros(material_num,1);
material_data(:,4) = zeros(material_num,1);
material_data_order = cell(material_num,1);
for k = 1:material_num
    index = find(data_ori(:,9) == k);
    material_data(k,3) = length(index);
    orders = unique(data_ori(index,8));
    material_data(k,4) = length(orders);
    material_data_order{k} = orders;
end