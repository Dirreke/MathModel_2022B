function [material_data, material_data_order] = q2_materials_data_fun(data_ori, width, height)
material_num = size(unique(data_ori(:, 9)), 1);
material_data = (1:material_num)';
material_data(:, 2) = zeros(material_num, 1);
material_data(:, 3) = zeros(material_num, 1);
material_data_order = cell(material_num, 1);

for k = 1:material_num
    index = find(data_ori(:, 9) == k);
    material_data(k, 2) = length(index);
    orders = unique(data_ori(index, 8));
    material_data(k, 3) = length(orders);
    material_data_order{k} = orders;
    
    % tags
    tmp_data = data_ori(index, :);
    [tmp_bins, rate] = q1_FFFD_fun(tmp_data, width, height);
    tmp_num_bins = length(tmp_bins);
    material_data(k, 4) = tmp_num_bins;
    material_data(k, 5) = rate;
end

%% sort
[~, index] = sort(material_data(:, 2), 'descend');
material_data = material_data(index, :);
material_data_order = material_data_order(index, :);
[~, index] = sort(material_data(:, 4));
material_data = material_data(index, :);
material_data_order = material_data_order(index, :);
[~, index] = sort(material_data(:, 3));
material_data = material_data(index, :);
material_data_order = material_data_order(index, :);

