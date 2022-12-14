file = [
    "../data/dataB/dataB1.csv", 
    "../data/dataB/dataB2.csv", 
    "../data/dataB/dataB3.csv", 
    "../data/dataB/dataB4.csv", 
    "../data/dataB/dataB5.csv"
    ];

results = cell(length(file), 1);
ratios = zeros(length(file), 1);
num_platess = zeros(length(file), 1);
parfor k = 1:length(file)
    [data_ori, material_index] = data_pre_fun(file(k));
    width = 1220;
    height = 2440;
    max_item_number = 1000;
    max_item_area = 250e6;
    [batches,ratio,num_plates] = q2_tanlan(data_ori,width,height,max_item_number,max_item_area);
    results{k} = batches;
    ratios(k) = ratio;
    num_platess(k) = num_plates;
    save_to_file_fun(2, k,results{k}, material_index);
%     draw_picture_fun(1, k);
    fprintf("数据集dataB%d的最优组批排样策略的板材利用率为%.2f\n ",k,100*ratios(k));
end
% %% 
% [data_ori, material_index] = data_pre_fun(file(1));

% width = 1220;
% height = 2440;
% material = unique(data_ori(:,9));
% num_plates = 0;
% for k  = 1:length(material)
%     i = material(k);
%     num_plate = ceil(sum(data_ori(data_ori(:,9) == i,5))/width/height);
    
%     num_plates = num_plates + num_plate;
    
% end
