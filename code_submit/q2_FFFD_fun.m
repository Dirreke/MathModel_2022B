function [material_packs,ratio,num_plates] = q2_FFFD_fun(data_ori, width, height, orders)
num = length(orders);

%% into_iter
tmp_items = [];

for tmp_order = orders
    tmp_items = [tmp_items; data_ori(data_ori(:, 8) == tmp_order, :)];
end

tmp_materials = unique(tmp_items(:, 9))';

material_pack.material_id = []; %材质序号
material_pack.bins = []; %所包含的bins
material_pack.items = []; %此订单此材质的所有items
material_pack.ratio = [];
material_packs = repmat(material_pack,1,length(tmp_materials));
num_plates = 0;

for k = 1:length(tmp_materials)
    tmp_material = tmp_materials(k);
    data_new = tmp_items(tmp_items(:, 9) == tmp_material, :);
    [tmp_bins,tmp_ratio,tmp_num_plates] = q1_FFFD_fun(data_new, width, height);
    
    material_pack.material_id = tmp_materials(k); %材质序号
    material_pack.bins = tmp_bins; %所包含的bins
    material_pack.items = data_new; %此订单此材质的所有items
    material_pack.ratio = tmp_ratio;
    material_packs(k) = material_pack;
    num_plates = num_plates + tmp_num_plates;
end
    ratio = sum(tmp_items(:, 5)) / width / height / num_plates;
end
